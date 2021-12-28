import 'package:distillers_calculator/helpers/number_field.dart';
import 'package:distillers_calculator/classes/table6.dart';
import 'package:flutter/material.dart';

import '../util/maths.dart';
//import 'package:distillers_calculator/screens/home/maths.dart';

class VolumePage extends StatefulWidget {
  VolumePage({Key? key}) : super();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Volume";

  @override
  _VolumePageState createState() => _VolumePageState();
}

class _VolumePageState extends State<VolumePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bottle Volume Calculator"),
        ),
        body: const MyCustomForm(),
        resizeToAvoidBottomInset: false);
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text:
                    'Commonly called a Bottle Dilution, make an amount of spirits in a desired % ',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            ),
            NumberField.getNumberField(
                volumeController, "Desired Volume in ml"),
            NumberField.getNumberField(
                fromPercentController, "ABV of source", 0, 100),
            NumberField.getNumberField(
                toPercentController,
                "Desired final ABV",
                0,
                int.tryParse(fromPercentController.text) != null
                    ? int.tryParse(fromPercentController.text)
                    : 100),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState!.validate()) {
                    var vals = Table6.volume(
                        int.parse(volumeController.text),
                        int.parse(fromPercentController.text),
                        int.parse(toPercentController.text));

                    answerSourceController.text =
                        vals.VolumeOfSourceToAdd.toString();
                    answerWaterController.text =
                        vals.VolumeOfWaterToAdd.toString();
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {});
                  }
                },
                child: Text('Calculate!'),
              ),
            ]),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
              child: TextFormField(
                controller: answerSourceController,
                readOnly: true,
                decoration: InputDecoration(
                    labelText: "Add this much of your spirit",
                    border: InputBorder.none),
              ),
            ),
            TextFormField(
              controller: answerWaterController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Add this much water",
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
