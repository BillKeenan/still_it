import 'package:flutter/material.dart';

import '../../util/maths.dart';
//import 'package:still_it/screens/home/maths.dart';

class DillutionPage extends StatefulWidget {
  DillutionPage({Key? key}) : super();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Volume";

  @override
  _DillutionPageState createState() => _DillutionPageState();
}

class _DillutionPageState extends State<DillutionPage> {
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
        title: const Text("Dillution Calculator"),
      ),
      body: const MyCustomForm(),
    );
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text:
                    'Have a jar of high % and want to adjust it down? This is the calculator for that',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                }
                return null;
              },
              controller: volumeController,
              decoration: InputDecoration(
                  labelText: "Volume",
                  border: InputBorder.none,
                  hintText: 'current Volume'),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                }
                return null;
              },
              controller: fromPercentController,
              decoration: InputDecoration(
                  labelText: "ABV of source",
                  border: InputBorder.none,
                  hintText: 'current ABV'),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your desired ABV';
                }
                return null;
              },
              controller: toPercentController,
              decoration: InputDecoration(
                  labelText: "Desired final ABV",
                  border: InputBorder.none,
                  hintText: 'What ABV do you want?'),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState!.validate()) {
                    var val = Maths.dillution(
                        int.parse(volumeController.text),
                        int.parse(fromPercentController.text),
                        int.parse(toPercentController.text));

                    answerWaterController.text = val.toString();
                    setState(() {});
                  }
                },
                child: Text('Calculate!'),
              ),
            ]),
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
