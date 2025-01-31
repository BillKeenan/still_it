import 'dart:io';
import 'dart:developer' as dev;

import 'package:distillers_calculator/classes/sql_helper.dart';
import 'package:distillers_calculator/model/batch.dart';
import 'package:distillers_calculator/model/image_note.dart';
import 'package:distillers_calculator/model/specific_gravity_note.dart';
import 'package:distillers_calculator/model/text_note.dart';
import 'package:distillers_calculator/model/sortable_note.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:distillers_calculator/util/maths.dart';
import 'package:distillers_calculator/widgets/image_note_widget.dart';
import 'package:distillers_calculator/widgets/image_overlay.dart';
import 'package:distillers_calculator/widgets/specific_gravity_overlay.dart';
import 'package:distillers_calculator/widgets/specific_gravity_widget.dart';
import 'package:distillers_calculator/widgets/text_entry_overlay.dart';
import 'package:distillers_calculator/widgets/text_note_widget.dart';
import 'package:distillers_calculator/widgets/text_overlay.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';

class BatchDetail extends StatefulWidget {
  final Batch batch;

  const BatchDetail({required this.batch, super.key});
  @override
  BatchDetailState createState() => BatchDetailState();
}

class BatchDetailState extends State<BatchDetail> {
  final _image = [];
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  List<SortableNote> notes = [];
  List<SpecificGravityNote> sgNotes = [];

  getNotes() async {
    try {
      var notesData = await SQLHelper.getTextNotes(widget.batch.id);
      var imgData = await SQLHelper.getImageNotes(widget.batch.id);
      var sgData = await SQLHelper.getSpecificGravityNotes(widget.batch.id);

      sgNotes = sgData;

      List<SortableNote> notesFuture = [];
      notesFuture.addAll(List.from(notesData)
        ..addAll(imgData)
        ..addAll(sgData));

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
              const SizedBox(height: 30),
              Text(widget.batch.name,
                  style: const TextStyle(
                      color: LightColors.kDarkBlue,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2)),
              getABVTable(),
              const SizedBox(height: 30),
              Expanded(child: getNotesList())
            ]),
            resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => setState(() {
                      _showChoiceForm(null);
                    }))));
  }

  _saveNote(String note) {
    SQLHelper.saveNote(widget.batch.id, note);

    setState(() {
      getNotes();
    });
  }

  _saveSG(num sg) {
    SQLHelper.saveSG(widget.batch.id, sg);

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _showSpecificGravityEntryOverlay(context);
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
                      "Specific\nGravity",
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
                          _showTextEntryOverlay(context);
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
                      "Text Note",
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
                          _showImageEntryOverlay(context);
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
                      "Image Note",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ])
                ])));
  }

  void _showTextEntryOverlay(BuildContext context) {
    Navigator.of(context).push(TextEntryOverlay(_saveNote));
  }

  _showSpecificGravityEntryOverlay(BuildContext context) {
    Navigator.of(context).push(SpecificGravityOverlay(_saveSG));
  }

  void _showTextOverlay(TextNote note) {
    Navigator.of(context).push(TextOverlay(note));
  }

  void _showImageOverlay(ImageNote note) {
    Navigator.of(context).push(ImageOverlay(note));
  }

  void _showImageEntryOverlay(BuildContext context) async {
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
    dev.log("added image:${selectedFile.path}");
  }

  _imgFromCamera(ImageSource source) async {
    var image = await _picker.pickImage(source: source);

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

  getABVTable() {
    double height = MediaQuery.of(context).size.height / 8;

    List<TableRow> rows = [];
    rows.add(TableRow(
      children: <Widget>[
        const SizedBox(height: 32, width: 60, child: Text("Batch Start Date")),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Align(
            alignment: Alignment.topRight,
            child: SizedBox(
                height: 32,
                width: 80,
                child: Text(DateFormat('MMM-dd')
                    .format(widget.batch.batchStartedDateAsDate))),
          ),
        ),
      ],
    ));
    rows.add(TableRow(
      children: <Widget>[
        const SizedBox(height: 32, width: 60, child: Text("Age of Batch")),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Align(
            alignment: Alignment.topRight,
            child: SizedBox(
                height: 32,
                width: 80,
                child: Text(DateTime.now()
                    .difference(widget.batch.batchStartedDateAsDate)
                    .inDays
                    .toString())),
          ),
        ),
      ],
    ));

    if (sgNotes.length > 1) {
      var abv = Maths.abvFromSg(sgNotes.last.sg, sgNotes.first.sg);

      rows.add(TableRow(
        children: <Widget>[
          const SizedBox(height: 32, width: 60, child: Text("Expected ABV")),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: 32,
                  width: 80,
                  child: Text(Maths.roundTo2Decimals(abv).toString()),
                )),
          ),
        ],
      ));
    }

    return SizedBox(
        height: height,
        child: Padding(
            padding: const EdgeInsets.all(40),
            child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(64),
                  1: FlexColumnWidth(64),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: rows)));
  }

  getNotesList() {
    double height = MediaQuery.of(context).size.height / 8;
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) {
        if (notes[index] is TextNote) {
          return TextNoteWidget(
              note: notes[index] as TextNote,
              height: height,
              callback: _showTextOverlay);
        } else if (notes[index] is ImageNote) {
          return ImageNoteWidget(
              note: notes[index] as ImageNote,
              height: height,
              callback: _showImageOverlay);
        } else if (notes[index] is SpecificGravityNote) {
          return SpecificGravityWidget(
              note: notes[index] as SpecificGravityNote, height: height);
        } else {
          throw UnimplementedError("unknown type of note");
        }
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
