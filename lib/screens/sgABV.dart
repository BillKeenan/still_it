import 'package:flutter/material.dart';
import 'package:still_it/theme/colors/light_colors.dart';

import '../util/maths.dart';
//import 'package:still_it/screens/home/maths.dart';

class SGPage extends StatefulWidget {
  SGPage({Key? key}) : super();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Volume";

  @override
  _SGPageState createState() => _SGPageState();
}

class _SGPageState extends State<SGPage> {
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
        title: const Text("ABV From Specific Gravity",
            style: TextStyle(
                color: LightColors.kDarkBlue,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2)),
        backgroundColor: LightColors.kDarkYellow,
        foregroundColor: LightColors.kDarkBlue,
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

  TextEditingController sg1Controller = TextEditingController();
  TextEditingController sg2Controller = TextEditingController();
  TextEditingController answerController = TextEditingController();

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
                    'Simple ABV calculator based on your Start and end Specific Gravity',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your starting SG';
                  }
                  return null;
                },
                controller: sg1Controller,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: sg1Controller.clear,
                    icon: Icon(Icons.clear),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Starting Specific Gravity',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your ending Volume';
                  }
                  return null;
                },
                controller: sg2Controller,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: sg2Controller.clear,
                    icon: Icon(Icons.clear),
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Ending Specific Gravity",
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState!.validate()) {
                    var vals = Maths.abvFromSg(
                      num.parse(sg1Controller.text),
                      num.parse(sg2Controller.text),
                    );

                    answerController.text = vals.toString();
                    setState(() {});
                  }
                },
                child: Text('Calculate!'),
              ),
            ]),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
              child: TextFormField(
                controller: answerController,
                readOnly: true,
                decoration: InputDecoration(
                    labelText: "Final ABV %", border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
