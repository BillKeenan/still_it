import 'package:flutter/material.dart';

import '../../util/maths.dart';
//import 'package:still_it/screens/home/maths.dart';

class SugarPage extends StatefulWidget {
  SugarPage({Key? key}) : super();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Volume";

  @override
  _SugarPageState createState() => _SugarPageState();
}

class _SugarPageState extends State<SugarPage> {
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
        title: const Text("Sugar Wash Calculator"),
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

  TextEditingController sugarController = TextEditingController();
  TextEditingController waterController = TextEditingController();
  TextEditingController answerWaterController = TextEditingController();
  TextEditingController answerSGController = TextEditingController();
  TextEditingController answerABVController = TextEditingController();

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
                    'Calculate how much water to add to achieve a desired ABV',
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
                    return "Enter how much sugar you are using";
                  }
                  return null;
                },
                controller: sugarController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: sugarController.clear,
                    icon: Icon(Icons.clear),
                  ),
                  border: OutlineInputBorder(),
                  labelText: "How Much Sugar in kg",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your desired ending Volume';
                  }
                  return null;
                },
                controller: waterController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: waterController.clear,
                    icon: Icon(Icons.clear),
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Desired Final Volume in Litres",
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState!.validate()) {
                    var vals = Maths.sugarWash(
                      int.parse(sugarController.text),
                      int.parse(waterController.text),
                    );

                    answerSGController.text = vals[0].toString();
                    answerWaterController.text = vals[1].toString();
                    answerABVController.text = vals[2].toString();
                    setState(() {});
                  }
                },
                child: Text('Calculate!'),
              ),
            ]),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
              child: TextFormField(
                controller: answerABVController,
                readOnly: true,
                decoration: InputDecoration(
                    labelText: "Expected Final ABV", border: InputBorder.none),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
              child: TextFormField(
                controller: answerWaterController,
                readOnly: true,
                decoration: InputDecoration(
                    labelText: "Add this much water", border: InputBorder.none),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
              child: TextFormField(
                controller: answerSGController,
                readOnly: true,
                decoration: InputDecoration(
                    labelText: "Expected Specific Gravity",
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
