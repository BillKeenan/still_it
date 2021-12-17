import 'package:distillers_calculator/routes.dart';
import 'package:distillers_calculator/screens/home.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}
