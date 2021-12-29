import 'package:distillers_calculator/classes/specific_gravity.dart';
import 'package:distillers_calculator/helpers/number_field.dart';
import 'package:flutter/material.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:flutter/services.dart';

import '../util/maths.dart';
//import 'package:distillers_calculator/screens/home/maths.dart';

class TempConvert extends StatefulWidget {
  TempConvert({Key? key}) : super();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Temperature Converter";

  @override
  _TempConverter createState() => _TempConverter();
}

class _TempConverter extends State<TempConvert> {
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
              title: const Text("Temperature Conversion",
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

  TextEditingController celciusController = TextEditingController();
  TextEditingController farenheightController = TextEditingController();
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
                text: 'Convert between C and F',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter ';
                  }

                  return null;
                },
                onChanged: (text) {
                  if (text == "") {
                    celciusController.text = "";
                  }
                  if (text == "-" || double.tryParse(text) == null) {
                    return;
                  }
                  var val = Maths.CtoF(double.parse(text));
                  farenheightController.text =
                      Maths.roundTo2Decimals(val).toString();
                },
                controller: celciusController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: celciusController.clear,
                    icon: const Icon(Icons.clear),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: "Celcius",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
              child: TextFormField(
                onChanged: (text) {
                  if (text == "") {
                    celciusController.text = "";
                  }
                  if (text == "-" || double.tryParse(text) == null) {
                    return;
                  }
                  var val = Maths.FtoC(double.parse(text));
                  celciusController.text =
                      Maths.roundTo2Decimals(val).toString();
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter ';
                  }

                  return null;
                },
                controller: farenheightController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: celciusController.clear,
                    icon: const Icon(Icons.clear),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: "Farenheight",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
