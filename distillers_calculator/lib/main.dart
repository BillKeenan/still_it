import 'package:distillers_calculator/routes.dart';
import 'package:distillers_calculator/screens/home.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            color: LightColors.kDarkYellow,
            foregroundColor: LightColors.kDarkBlue),
        scaffoldBackgroundColor: LightColors.kLightYellow,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: LightColors.kDarkYellow)),
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: LightColors.kDarkBlue,
            displayColor: LightColors.kDarkBlue,
            fontFamily: 'Poppins'),
      ),
      title: 'Distillers Calculator',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}
