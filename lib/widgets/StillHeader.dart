import 'package:flutter/material.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';

import 'TopContainer.dart';

class StillHeader extends StatelessWidget {
  StillHeader();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return TopContainer(
      height: 200,
      width: width,
      padding: EdgeInsets.all(0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Distillers Calculators',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: LightColors.kDarkBlue,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ]),
    );
  }
}
