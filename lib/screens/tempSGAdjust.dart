import 'package:distillers_calculator/classes/specific_gravity.dart';
import 'package:distillers_calculator/helpers/number_field.dart';
import 'package:flutter/material.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:flutter/services.dart';

import '../util/maths.dart';
//import 'package:distillers_calculator/screens/home/maths.dart';

class TempSGAdjust extends StatefulWidget {
  TempSGAdjust({Key? key}) : super();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Temperature Adjust";

  @override
  _TempSGAdjust createState() => _TempSGAdjust();
}

class _TempSGAdjust extends State<TempSGAdjust> {
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
              title: const Text("Temperature Adjustment",
                  style: TextStyle(
                      color: LightColors.kDarkBlue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2)),
              backgroundColor: LightColors.kDarkYellow,
              foregroundColor: LightColors.kDarkBlue,
            ),
            body: const MyCustomForm(),
            resizeToAvoidBottomInset: false));
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
  TextEditingController calibrationController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  SnackBar get snackBar => SnackBar(
        content: const Text("Specific Gravity copied to clipboard"),
      );

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
                text: 'Adjust your SG reading for your current temperature',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            ),
            NumberFieldHelper.getNumberField(calibrationController,
                "Hydromter Calibration Temp (c)", 10, 20, 15),
            NumberFieldHelper.getNumberField(
                sg1Controller, "Specific Gravity Reading"),
            NumberFieldHelper.getNumberField(sg2Controller, "Current Temp (c)"),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState!.validate()) {
                    var vals = Maths.sgTempAdjust(
                        SpecificGravity(num.parse(sg1Controller.text)),
                        num.parse(sg2Controller.text),
                        num.parse(calibrationController.text));

                    answerController.text =
                        Maths.roundToXDecimals(vals.sg, 4).toString();
                    setState(() {});
                  }
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Text('Calculate!'),
              ),
            ]),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
              child: TextFormField(
                controller: answerController,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: answerController.text))
                      .then((value) {
                    //only if ->
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                readOnly: true,
                decoration: InputDecoration(
                    labelText: "Adjusted SG, click to copy",
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
