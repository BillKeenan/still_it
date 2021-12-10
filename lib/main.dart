import 'package:flutter/material.dart';
import 'package:still_it/routes.dart';
import 'package:still_it/screens/home/home.dart';
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
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: LightColors.kDarkBlue,
            displayColor: LightColors.kDarkBlue,
            fontFamily: 'Poppins'),
      ),
      title: 'Still it Calculator',
      home: HomePage(),
      routes: routes,
    );
  }
}
