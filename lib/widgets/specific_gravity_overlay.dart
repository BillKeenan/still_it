import 'package:distillers_calculator/screens/temp_sg_adjust.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class SpecificGravityOverlay extends ModalRoute<void> {
  Function saveSG;

  num? sg;

  getSG(num specificGravity) {
    sg = specificGravity;
  }

  SpecificGravityOverlay(this.saveSG);

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
    return Material(
        type: MaterialType.transparency,
        // make sure that the overlay content is not cut off
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SpecificGravityForm.withCallback(getSG: getSG),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Dismiss'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (sg != null) {
                            saveSG(sg);
                          }
                        },
                        child: const Text('Save Note'),
                      )
                    ]),
                  ],
                ),
              ),
            )));
  }
}
