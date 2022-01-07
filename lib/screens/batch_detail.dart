import 'dart:io';
import 'dart:developer' as dev;
import 'package:distillers_calculator/classes/batch.dart';
import 'package:distillers_calculator/classes/note.dart';
import 'package:distillers_calculator/classes/sql_helper.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:distillers_calculator/widgets/batch_detail_form.dart';
import 'package:distillers_calculator/widgets/notes_form.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class BatchDetail extends StatefulWidget {
  final int batchID;

  const BatchDetail({required this.batchID, Key? key}) : super(key: key);
  @override
  _BatchDetailState createState() => _BatchDetailState();
}

class _BatchDetailState extends State<BatchDetail> {
  final _image = [];
  final _picker = ImagePicker();
  var _isLoading = true;
  var _notesLoading = true;

  @override
  void initState() {
    super.initState();
    getAsync();
    getNotes();
  }

  Batch batch = Batch.empty();
  List<Note> notes = [];

  getAsync() async {
    try {
      var data = await SQLHelper.getItem(widget.batchID);
      setState(() {
        batch = data;
        _isLoading = false;
      });
    } catch (e) {
      dev.log(e.toString());
    }
  }

  getNotes() async {
    try {
      var notesData = await SQLHelper.getNotes(widget.batchID);
      setState(() {
        notes = notesData;
        _notesLoading = false;
      });
    } catch (e) {
      dev.log(e.toString());
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
            body: getNotesList(),
            resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => setState(() {
                      _showChoiceForm(null);
                    }))) //get json fname

        );
  }

  _saveNote(String note) {
    if (batch.id == null) {
      throw ArgumentError("invalid batch id");
    }
    SQLHelper.saveNote(batch.id!, note);
    setState(() {});
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

  void addImage(File selectedFile) {
    _image.add(selectedFile);
    GallerySaver.saveImage(selectedFile.path);
    dev.log("test");
  }

  _imgFromCamera(ImageSource source) async {
    var pickedFile = await _picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        addImage(File(pickedFile.path));
      } else {
        dev.log('No image selected.');
      }
    });
  }

  getNotesList() {
    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text("a"),
              ),
              title: Text(notes[position].note!,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              onTap: () {
                debugPrint("ListTile Tapped");
              },
            ),
          );
        });
  }
}

class TextEntryOverlay extends ModalRoute<void> {
  Function saveNote;
  TextEntryOverlay(this.saveNote);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => true;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => LightColors.kLightYellow;

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;
  var textFormField = TextEditingController();
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
        type: MaterialType.transparency,
        // make sure that the overlay content is not cut off
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Enter in notes here',
                  style:
                      TextStyle(color: LightColors.kDarkBlue, fontSize: 30.0),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
                  child: TextFormField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: textFormField,
                    maxLines: 10,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: textFormField.clear,
                        icon: const Icon(Icons.clear),
                      ),
                      border: const OutlineInputBorder(),
                      labelText: "test",
                    ),
                  ),
                ),
                Row(children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Dismiss'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      saveNote(textFormField.text);
                    },
                    child: const Text('Save Note'),
                  )
                ]),
              ],
            ),
          ),
        ));
  }
}
