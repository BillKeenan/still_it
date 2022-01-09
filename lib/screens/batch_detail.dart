import 'dart:io';
import 'dart:developer' as dev;

import 'package:distillers_calculator/classes/sql_helper.dart';
import 'package:distillers_calculator/model/batch.dart';
import 'package:distillers_calculator/model/image_note.dart';
import 'package:distillers_calculator/model/note.dart';
import 'package:distillers_calculator/model/sortable_note.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:distillers_calculator/widgets/text_entry_overlay.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';

class BatchDetail extends StatefulWidget {
  final Batch batch;

  const BatchDetail({required this.batch, Key? key}) : super(key: key);
  @override
  _BatchDetailState createState() => _BatchDetailState();
}

class _BatchDetailState extends State<BatchDetail> {
  final _image = [];
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  List<SortableNote> notes = [];

  getNotes() async {
    try {
      var notesData = await SQLHelper.getTextNotes(widget.batch.id);
      var imgData = await SQLHelper.getImageNotes(widget.batch.id);

      List<SortableNote> notesFuture = [];
      notesFuture.addAll(List.from(notesData)..addAll(imgData));

      notesFuture.sort((b, a) => a.createdAtDate.compareTo(b.createdAtDate));
      setState(() {
        notes = notesFuture;
      });
    } catch (e) {
      dev.log(e.toString());
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: curly_braces_in_flow_control_structures

    return Container(
        color: Colors.white,
        child: Scaffold(
            key: GlobalKey(),
            appBar: AppBar(
              title: const Text("Batch Diary",
                  style: TextStyle(
                      color: LightColors.kDarkBlue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2)),
              backgroundColor: LightColors.kDarkYellow,
              foregroundColor: LightColors.kDarkBlue,
            ),
            backgroundColor: LightColors.kLightYellow,
            body: Column(children: [
              Text(widget.batch.name,
                  style: const TextStyle(
                      color: LightColors.kDarkBlue,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2)),
              Expanded(child: getNotesList())
            ]),
            resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => setState(() {
                      _showChoiceForm(null);
                    }))) //get json fname

        );
  }

  _saveNote(String note) {
    SQLHelper.saveNote(widget.batch.id, note);

    setState(() {
      getNotes();
    });
  }

  _showChoiceForm(int? id) async {
    return showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
            padding: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              // this will prevent the soft keyboard from covering the text fields
              bottom: MediaQuery.of(context).viewInsets.bottom + 120,
            ),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _showOverlay(context);
                        },
                        child: const CircleAvatar(
                          radius: 20.0,
                          backgroundColor: LightColors.kRed,
                          child: Icon(
                            Icons.note_add,
                            size: 30,
                            color: Colors.white,
                          ),
                        )),
                    const Text(
                      "Add Note",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ]),
                  const SizedBox(
                    width: 30.0,
                  ),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _showImageForm(context);
                        },
                        child: const CircleAvatar(
                          radius: 20.0,
                          backgroundColor: LightColors.kRed,
                          child: Icon(
                            Icons.photo_album,
                            size: 30,
                            color: Colors.white,
                          ),
                        )),
                    const Text(
                      "Add Photo",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ])
                ])));
  }

  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(TextEntryOverlay(_saveNote));
  }

  void _showImageForm(BuildContext context) async {
    // Ensure that plugin services are initialized so that `availableCameras()`
// can be called before `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera(ImageSource.camera);
                    }),
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      _imgFromCamera(ImageSource.gallery);
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }

  void _saveImage(File selectedFile) {
    _image.add(selectedFile);
    SQLHelper.saveImageNote(widget.batch.id, selectedFile.path);
    dev.log("added image:" + selectedFile.path);
  }

  _imgFromCamera(ImageSource source) async {
    var image = await _picker.getImage(source: source);

    final path = await getApplicationDocumentsDirectory();

    String savePath = path.path;
    String fileName =
        sprintf("Batch:%s:%s", [widget.batch.id, const Uuid().v4()]);

    final File newImage = await File(image!.path).copy('$savePath/$fileName');

// copy the file to a new path
    setState(() {
      _saveImage(File(newImage.path));
      getNotes();
    });
  }

  getNotesList() {
    double height = MediaQuery.of(context).size.height / 5;
    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int position) {
          if (notes[position] is TextNote) {
            TextNote thisNote = notes[position] as TextNote;

            return Column(children: [Text(thisNote.note)]);
          } else if (notes[position] is ImageNote) {
            ImageNote thisNote = notes[position] as ImageNote;

            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(thisNote.imagePath, height: height),
            );
          } else {
            throw UnimplementedError("unkwonn type of note");
          }
        });
  }
}
