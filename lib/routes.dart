import 'package:distillers_calculator/screens/dilution.dart';
import 'package:distillers_calculator/screens/liqueur.dart';
import 'package:distillers_calculator/screens/sugar.dart';
import 'package:distillers_calculator/screens/tempConverter.dart';
import 'package:distillers_calculator/screens/tempSGAdjust.dart';
import 'package:flutter/widgets.dart';
import 'package:distillers_calculator/screens/sgABV.dart';
import 'package:distillers_calculator/screens/volume.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/Volume": (BuildContext context) => VolumePage(),
  "/Dilution": (BuildContext context) => DilutionPage(),
  "/Sugar": (BuildContext context) => SugarPage(),
  "/SpecificGravity": (BuildContext context) => SGPage(),
  "/TempAdjust": (BuildContext context) => TempSGAdjust(),
  "/TempConvert": (BuildContext context) => TempConvert(),
  "/Liqueur": (BuildContext context) => LiqueurPage(),
};
