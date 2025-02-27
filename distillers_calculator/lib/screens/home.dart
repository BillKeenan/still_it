import 'package:distillers_calculator/screens/batch_list.dart';
import 'package:distillers_calculator/screens/dilution.dart';
import 'package:distillers_calculator/screens/liqueur.dart';
import 'package:distillers_calculator/screens/sg_abv.dart';
import 'package:distillers_calculator/screens/sugar.dart';
import 'package:distillers_calculator/screens/temp_converter.dart';
import 'package:distillers_calculator/screens/temp_sg_adjust.dart';
import 'package:distillers_calculator/screens/volume.dart';
import 'package:flutter/material.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:distillers_calculator/widgets/still_header.dart';
import 'package:distillers_calculator/widgets/task_column.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();

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

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // _showVersionChecker(context); //calling the method
  }

  var selectedPage = 0;
  final _pageOptions = [homeScreen(), calculatorScreen()];

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

// void _showVersionChecker(BuildContext context) {
//   try {
//     NewVersion(
//       iOSId: 'net.bigmojo.distillers', //dummy IOS bundle ID
//       androidId: 'net.bigmojo.net.distillers', //dummy android ID
//     ).showAlertIfNecessary(context: context);
//   } catch (e) {
//     debugPrint("error=====>${e.toString()}");
//   }
// }

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
                TaskColumn(
                    iconSize: 30,
                    icon: Icons.query_stats_rounded,
                    iconBackgroundColor: LightColors.kRed,
                    title: 'Specific Gravity adjustment',
                    subtitle: 'Adjust SG for temperature',
                    onTapNav: const TempSGAdjust()),
                const SizedBox(height: 15.0),
                TaskColumn(
                    iconSize: 30,
                    icon: Icons.thermostat,
                    iconBackgroundColor: LightColors.kRed,
                    title: 'Celcius to Farenheight',
                    subtitle: 'Basic Temperature Conversions',
                    onTapNav: const TempConvert()),
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
                      TaskColumn(
                          iconSize: 30,
                          icon: Icons.query_stats_rounded,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'ABV from Specific Gravity',
                          subtitle: 'What % did your wash end at',
                          onTapNav: const SGPage()),
                      const SizedBox(height: 15.0),
                      TaskColumn(
                          iconSize: 30,
                          icon: Icons.liquor_outlined,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'Bottle Dilution',
                          subtitle: 'Make a bottle at a desired %',
                          onTapNav: const VolumePage()),
                      const SizedBox(
                        height: 15.0,
                      ),
                      TaskColumn(
                          iconSize: 30,
                          icon: Icons.sanitizer_outlined,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'Dilution Calculator',
                          subtitle: 'Dillute a volume down to a %',
                          onTapNav: const DilutionPage()),
                      const SizedBox(height: 15.0),
                      TaskColumn(
                          iconSize: 30,
                          icon: Icons.local_drink_outlined,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'Sugar Wash Calculator',
                          subtitle: 'How much sugar? How much water?',
                          onTapNav: const SugarPage()),
                      const SizedBox(height: 15.0),
                      TaskColumn(
                          iconSize: 30,
                          icon: Icons.local_drink_outlined,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'Batch Log',
                          subtitle: 'Keep a diary of your run',
                          onTapNav: const BatchList()),
                      const SizedBox(height: 15.0),
                      TaskColumn(
                          iconSize: 30,
                          icon: Icons.no_drinks,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'Liqueur Calculator',
                          subtitle: 'Whats the final ABV?',
                          onTapNav: const LiqueurPage()),
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
