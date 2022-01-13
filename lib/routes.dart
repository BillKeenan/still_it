import 'package:distillers_calculator/screens/batch_list.dart';
import 'package:distillers_calculator/screens/dilution.dart';
import 'package:distillers_calculator/screens/liqueur.dart';
import 'package:distillers_calculator/screens/sugar.dart';
import 'package:distillers_calculator/screens/temp_converter.dart';
import 'package:distillers_calculator/screens/temp_sg_adjust.dart';
import 'package:flutter/widgets.dart';
import 'package:distillers_calculator/screens/sg_abv.dart';
import 'package:distillers_calculator/screens/volume.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/Volume": (BuildContext context) => const VolumePage(),
  "/Dilution": (BuildContext context) => const DilutionPage(),
  "/Sugar": (BuildContext context) => const SugarPage(),
  "/SpecificGravity": (BuildContext context) => const SGPage(),
  "/TempAdjust": (BuildContext context) => const TempSGAdjust(),
  "/TempConvert": (BuildContext context) => const TempConvert(),
  "/Batch": (BuildContext context) => const BatchList(),
  "/Liqueur": (BuildContext context) => LiqueurPage(),
};
