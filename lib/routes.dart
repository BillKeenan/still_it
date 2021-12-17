import 'package:distillers_calculator/screens/sugar.dart';
import 'package:flutter/widgets.dart';
import 'package:distillers_calculator/screens/dillution.dart';
import 'package:distillers_calculator/screens/sgABV.dart';
import 'package:distillers_calculator/screens/volume.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/Volume": (BuildContext context) => VolumePage(),
  "/Dillution": (BuildContext context) => DillutionPage(),
  "/Sugar": (BuildContext context) => SugarPage(),
  "/SpecificGravity": (BuildContext context) => SGPage(),
};
