import 'package:distillers_calculator/model/image_note.dart';
import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ImageOverlay extends ModalRoute<void> {
  ImageNote image;

  ImageOverlay(this.image);

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
          child: PinchZoom(
            maxScale: 2.5,
            onZoomStart: () {},
            onZoomEnd: () {},
            child: Image.asset(
              image.imagePath,
              //fit: BoxFit.cover,
              //height: double.infinity,
              //width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
        ));
  }
}
