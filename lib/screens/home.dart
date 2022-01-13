import 'package:flutter/material.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:distillers_calculator/widgets/still_header.dart';
import 'package:distillers_calculator/widgets/task_column.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();

  static Text subheading(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }
}

class _HomePage extends State<HomePage> {
  final _pageOptions = [homeScreen(), calculatorScreen()];
  var selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: _pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Calculators',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Conversions',
          ),
        ],
        currentIndex: selectedPage,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}

calculatorScreen() {
  return SafeArea(
      top: false,
      child: Column(children: <Widget>[
        const StillHeader(),
        Expanded(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          Container(
              color: Colors.transparent,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    HomePage.subheading('Conversions'),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const TaskColumn(
                    iconSize: 30,
                    icon: Icons.query_stats_rounded,
                    iconBackgroundColor: LightColors.kRed,
                    title: 'Specific Gravity adjustment',
                    subtitle: 'Adjust SG for temperature',
                    onTapNav: '/TempAdjust'),
                const SizedBox(height: 15.0),
                const TaskColumn(
                    iconSize: 30,
                    icon: Icons.thermostat,
                    iconBackgroundColor: LightColors.kRed,
                    title: 'Celcius to Farenheight',
                    subtitle: 'Basic Temperature Conversions',
                    onTapNav: '/TempConvert'),
                const SizedBox(height: 15.0)
              ]))
        ])))
      ]));
}

homeScreen() {
  return SafeArea(
    top: false,
    child: Column(
      children: <Widget>[
        const StillHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 40.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          HomePage.subheading('Calculators'),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const TaskColumn(
                          iconSize: 30,
                          icon: Icons.query_stats_rounded,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'ABV from Specific Gravity',
                          subtitle: 'What % did your wash end at',
                          onTapNav: '/SpecificGravity'),
                      const SizedBox(height: 15.0),
                      const TaskColumn(
                          iconSize: 30,
                          icon: Icons.liquor_outlined,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'Bottle Dilution',
                          subtitle: 'Make a bottle at a desired %',
                          onTapNav: '/Volume'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const TaskColumn(
                          iconSize: 30,
                          icon: Icons.sanitizer_outlined,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'Dilution Calculator',
                          subtitle: 'Dilute a volume down to a %',
                          onTapNav: '/Dilution'),
                      const SizedBox(height: 15.0),
                      const TaskColumn(
                          iconSize: 30,
                          icon: Icons.local_drink_outlined,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'Sugar Wash Calculator',
                          subtitle: 'How much sugar? How much water?',
                          onTapNav: '/Sugar'),
                      const TaskColumn(
                          iconSize: 30,
                          icon: Icons.local_drink_outlined,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'BVatch',
                          subtitle: 'How much sugar? How much water?',
                          onTapNav: '/Batch'),
                      SizedBox(height: 15.0),
                      TaskColumn(
                          iconSize: 30,
                          icon: Icons.no_drinks,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'Liqueur Calculator',
                          subtitle: 'Whats the final ABV?',
                          onTapNav: '/Liqueur'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
