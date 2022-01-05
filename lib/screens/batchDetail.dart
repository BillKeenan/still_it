import 'package:distillers_calculator/classes/batch.dart';
import 'package:distillers_calculator/classes/sqlHelper.dart';
import 'package:distillers_calculator/helpers/text_field.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class BatchDetail extends StatefulWidget {
  final int id;
  const BatchDetail({required this.id, Key? key}) : super();
  @override
  _BatchDetailState createState() => _BatchDetailState();
}

class _BatchDetailState extends State<BatchDetail> {
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
      print(e);
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (batch == null)
      return Center(child: CircularProgressIndicator());
    else
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
              ),
              resizeToAvoidBottomInset: false,
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => _showForm(null),
              )) //get json fname

          );
  }

  void _showForm(int? id) async {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();

    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal = _titleController.text = "test";
      _descriptionController.text = "test";
    }

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
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
                  SizedBox(
                    width: 30.0,
                  ),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    CircleAvatar(
                      radius: 20.0,
                      backgroundColor: LightColors.kRed,
                      child: Icon(
                        Icons.photo_album,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Add Photo",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ])
                ])));
  }
}

// Create a Form widget.
class BatchDetailForm extends StatefulWidget {
  final Batch batch;

  const BatchDetailForm({
    Key? key,
    required this.batch,
  }) : super(key: key);

  @override
  BatchDetailFormState createState() {
    return BatchDetailFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class BatchDetailFormState extends State<BatchDetailForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  TextEditingController volumeController = TextEditingController();
  TextEditingController fromPercentController = TextEditingController();
  TextEditingController toPercentController = TextEditingController();
  TextEditingController answerSourceController = TextEditingController();
  TextEditingController answerWaterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(25.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RichText(
                text: TextSpan(
                  text: 'A journal for your brewing',
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.5),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextFieldHelper.getTextField(
                  volumeController, "Batch Name", widget.batch.name ?? "")
            ])));
  }
}
