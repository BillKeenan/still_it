import 'package:distillers_calculator/model/text_note.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextNoteWidget extends StatelessWidget {
  final TextNote note;
  final double height;

  final Function callback;

  const TextNoteWidget(
      {Key? key,
      required this.note,
      required this.height,
      required this.callback})
      : super(key: key);

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
          onTap: () {
            callback(note);
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(note.note),
                  color: LightColors.kDarkYellow)),
        ),
      )
    ]);
  }
}
