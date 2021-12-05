import 'package:flutter/widgets.dart';
import 'package:still_it/screens/home/dillution.dart';
import 'package:still_it/screens/home/volume.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/Volume": (BuildContext context) => VolumePage(),
  "/Dillution": (BuildContext context) => DillutionPage(),
};
