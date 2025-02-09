import 'package:distillers_calculator/model/specific_gravity_note.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:distillers_calculator/util/maths.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpecificGravityWidget extends StatelessWidget {
  final SpecificGravityNote note;
  final double height;

  const SpecificGravityWidget(
      {super.key, required this.note, required this.height});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(children: [
        Text(DateFormat('MMM-dd').format(note.createdAtDate)),
        Text(DateFormat('kk:mm').format(note.createdAtDate))
      ]),
      const SizedBox(width: 30),
      Expanded(
          child: GestureDetector(
              onTap: () {},
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                      padding: const EdgeInsets.all(00),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                              padding: const EdgeInsets.all(20),
                              color: LightColors.kLightGreen,
                              child: Text(Maths.roundToXDecimals(note.sg.sg, 4)
                                  .toString())))))))
    ]);
  }
}
