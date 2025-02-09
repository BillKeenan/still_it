import 'package:distillers_calculator/helpers/number_field.dart';
import 'package:flutter/material.dart';

import '../util/maths.dart';
//import 'package:distillers_calculator/screens/home/maths.dart';

class LiqueurPage extends StatefulWidget {
  const LiqueurPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Volume";

  @override
  LiqueurPageState createState() => LiqueurPageState();
}

class LiqueurPageState extends State<LiqueurPage> {
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
          title: const Text("Liqueur ABV Calculator"),
        ),
        body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: const SingleChildScrollView(child: MyCustomForm())),
        resizeToAvoidBottomInset: true);
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

  TextEditingController waterController = TextEditingController();
  TextEditingController sugarController = TextEditingController();
  TextEditingController sourceABVController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
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
                text: 'You\'ve mixed a liqueur, what\'s the final ABV?\n ',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'This is an estimate ',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.5),
              ),
            ),
            NumberFieldHelper.getNumberField(
                waterController, "How Much water did you add (ml)?"),
            NumberFieldHelper.getNumberField(
                sourceController, "How Much alcohol did you add (ml)?"),
            NumberFieldHelper.getNumberField(
                sourceABVController, "ABV of alcohol", 0, 100),
            NumberFieldHelper.getNumberField(
                sugarController, "How Much sugar did you add (gm)?"),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState!.validate()) {
                    var vals = Maths.liqueur(
                        int.parse(waterController.text),
                        int.parse(sourceController.text),
                        int.parse(sourceABVController.text),
                        int.parse(sugarController.text));

                    answerABVController.text =
                        Maths.roundToXDecimals(vals, 2).toString();
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {});
                  }
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
                    labelText: "final ABV of your liqueur",
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
