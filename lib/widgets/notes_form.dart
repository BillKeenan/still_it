// Create a Form widget.
import 'package:distillers_calculator/classes/batch.dart';
import 'package:distillers_calculator/classes/note.dart';
import 'package:distillers_calculator/helpers/text_field.dart';
import 'package:flutter/material.dart';

class NotesForm extends StatefulWidget {
  final Batch batch;

  final List<Note> notes = [];

  NotesForm({
    Key? key,
    required this.batch,
    required List<Note> notes,
  }) : super(key: key);

  @override
  NotesFormState createState() {
    return NotesFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class NotesFormState extends State<NotesForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List notesWidgets = [];
    double height = MediaQuery.of(context).size.height / 5;

    for (var i = 0; i < widget.notes.length; i++) {
      notesWidgets.add(Text(widget.notes[i].note!));
      notesWidgets.add(const SizedBox(
        height: 30.0,
      ));
    }

    var imageContainer = Container(
        alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [...notesWidgets]));

    // Build a Form widget using the _formKey created above.
    TextEditingController batchNameController = TextEditingController();

    return Scaffold(
        key: _formKey,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    batchNameController, "Batch Name", widget.batch.name ?? ""),
                imageContainer
              ])),
        ));
  }
}
