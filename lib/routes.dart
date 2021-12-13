import 'package:flutter/widgets.dart';
import 'package:still_it/screens/dillution.dart';
import 'package:still_it/screens/sgABV.dart';
import 'package:still_it/screens/volume.dart';
import 'package:still_it/screens/sugar.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/Volume": (BuildContext context) => VolumePage(),
  "/Dillution": (BuildContext context) => DillutionPage(),
  "/Sugar": (BuildContext context) => SugarPage(),
  "/SpecificGravity": (BuildContext context) => SGPage(),
};
