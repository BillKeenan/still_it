// Create a Form widget.
import 'package:distillers_calculator/classes/batch.dart';
import 'package:distillers_calculator/helpers/text_field.dart';
import 'package:flutter/widgets.dart';

class BatchDetailForm extends StatefulWidget {
  final Batch batch;

  final List image;

  const BatchDetailForm({
    Key? key,
    required this.batch,
    required this.image,
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

  @override
  Widget build(BuildContext context) {
    List photoWidgets = [];
    double height = MediaQuery.of(context).size.height / 5;

    for (var i = 0; i < widget.image.length; i++) {
      photoWidgets.add(
          Image.file(widget.image[i], fit: BoxFit.fitWidth, height: height));
      photoWidgets.add(const SizedBox(
        height: 30.0,
      ));
    }

    var imageContainer = Container(
        alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [...photoWidgets]));

    // Build a Form widget using the _formKey created above.
    TextEditingController batchNameController = TextEditingController();

    return Form(
        key: _formKey,
        child: Padding(
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
