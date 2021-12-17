import 'package:flutter/material.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:distillers_calculator/widgets/StillHeader.dart';
import 'package:distillers_calculator/widgets/TaskColumn.dart';

class HomePage extends StatelessWidget {
  Text subheading(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            StillHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('Calculators'),
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TaskColumn(
                              iconSize: 30,
                              icon: Icons.query_stats_rounded,
                              iconBackgroundColor: LightColors.kRed,
                              title: 'ABV from Specific Gravity',
                              subtitle: 'What % did your wash end at',
                              onTapNav: '/SpecificGravity'),
                          SizedBox(height: 15.0),
                          TaskColumn(
                              iconSize: 30,
                              icon: Icons.liquor_outlined,
                              iconBackgroundColor: LightColors.kRed,
                              title: 'Bottle Dillution',
                              subtitle: 'Make a bottle at a desired %',
                              onTapNav: '/Volume'),
                          SizedBox(
                            height: 15.0,
                          ),
                          TaskColumn(
                              iconSize: 30,
                              icon: Icons.sanitizer_outlined,
                              iconBackgroundColor: LightColors.kRed,
                              title: 'Dillution Calculator',
                              subtitle: 'Dillute a volume down to a %',
                              onTapNav: '/Dillution'),
                          SizedBox(height: 15.0),
                          TaskColumn(
                              iconSize: 30,
                              icon: Icons.local_drink_outlined,
                              iconBackgroundColor: LightColors.kRed,
                              title: 'Sugar Wash Calculator',
                              subtitle: 'How much sugar? How much water?',
                              onTapNav: '/Sugar'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
