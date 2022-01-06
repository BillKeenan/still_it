import 'dart:io';
import 'dart:developer' as dev;
import 'package:distillers_calculator/classes/batch.dart';
import 'package:distillers_calculator/classes/sqlHelper.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:distillers_calculator/widgets/batch_detail_form.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class BatchDetail extends StatefulWidget {
  final int id;

  const BatchDetail({required this.id, Key? key}) : super(key: key);
  @override
  _BatchDetailState createState() => _BatchDetailState();
}

class _BatchDetailState extends State<BatchDetail> {
  final _image = [];
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getAsync();
  }

  late Batch batch;

  getAsync() async {
    try {
      batch = await SQLHelper.getItem(widget.id);
    } catch (e) {
      dev.log(e.toString());
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: curly_braces_in_flow_control_structures
    return Container(
        color: Colors.white,
        child: Scaffold(
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
            body: BatchDetailForm(
              batch: batch,
              image: _image,
            ),
            resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => setState(() {
                      _showChoiceForm(null);
                    }))) //get json fname

        );
  }

  void _showChoiceForm(int? id) async {
    showModalBottomSheet(
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
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        CircleAvatar(
                          radius: 20.0,
                          backgroundColor: LightColors.kRed,
                          child: Icon(
                            Icons.note_add,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Text(
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
                          _showImageForm(null);
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

  void _showImageForm(int? id) async {
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
                      Navigator.of(context).pop();
                    }),
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      _imgFromCamera(ImageSource.gallery);
                      Navigator.of(context).pop();
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
}
