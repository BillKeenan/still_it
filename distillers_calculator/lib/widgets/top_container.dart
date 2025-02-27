import 'package:flutter/material.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;
  const TopContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.child,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: const BoxDecoration(
          color: LightColors.kDarkYellow,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
