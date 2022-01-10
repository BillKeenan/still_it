import 'package:distillers_calculator/model/text_note.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class TextOverlay extends ModalRoute<void> {
  TextNote textNote;

  TextOverlay(this.textNote);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => true;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => LightColors.kLightYellow;

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;
  var textFormField = TextEditingController();
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Material(
            type: MaterialType.transparency,
            // make sure that the overlay content is not cut off
            child: Expanded(
                child: SafeArea(
                    maintainBottomViewPadding: true,
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(children: [Text(textNote.note)]))))));
  }
}
