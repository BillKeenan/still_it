import 'package:distillers_calculator/helpers/number_field.dart';
import 'package:flutter/material.dart';

import '../../util/maths.dart';
//import 'package:distillers_calculator/screens/home/maths.dart';

class SugarPage extends StatefulWidget {
  const SugarPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Volume";

  @override
  SugarPageState createState() => SugarPageState();
}

class SugarPageState extends State<SugarPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Sugar Wash Calculator"),
            ),
            body: const SingleChildScrollView(child: MyCustomForm()),
            resizeToAvoidBottomInset: false));
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

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
        padding: const EdgeInsets.all(16.0),
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
            NumberFieldHelper.getNumberField(sugarController, "KG of Sugar"),
            NumberFieldHelper.getNumberField(
                waterController, "Volume of Water (L)"),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState!.validate()) {
                    var vals = Maths.sugarWash(
                      num.parse(sugarController.text),
                      num.parse(waterController.text),
                    );

                    answerSGController.text = vals[0].toString();
                    answerWaterController.text = vals[1].toString();
                    answerABVController.text = vals[2].toString();
                    setState(() {});
                  }
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: const Text('Calculate!'),
              ),
            ]),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
              child: TextFormField(
                controller: answerABVController,
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: "Expected Final ABV", border: InputBorder.none),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 0),
              child: TextFormField(
                controller: answerWaterController,
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: "Add this much water", border: InputBorder.none),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 0),
              child: TextFormField(
                controller: answerSGController,
                readOnly: true,
                decoration: const InputDecoration(
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
