import 'package:flutter/material.dart';
import 'package:still_it/routes.dart';
import 'package:still_it/screens/home.dart';
import 'package:still_it/theme/colors/light_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: LightColors.kDarkYellow,
            foregroundColor: LightColors.kDarkBlue),
        scaffoldBackgroundColor: LightColors.kLightYellow,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(primary: LightColors.kDarkYellow)),
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: LightColors.kDarkBlue,
            displayColor: LightColors.kDarkBlue,
            fontFamily: 'Poppins'),
      ),
      title: 'Distillers Calculator',
      home: HomePage(),
      routes: routes,
    );
  }
}
