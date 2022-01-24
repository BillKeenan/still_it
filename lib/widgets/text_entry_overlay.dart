import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class TextEntryOverlay extends ModalRoute<void> {
  Function saveNote;
  TextEntryOverlay(this.saveNote);

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
        child: SafeArea(
            child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Enter in notes here',
                  style:
                      TextStyle(color: LightColors.kDarkBlue, fontSize: 30.0),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
                  child: TextFormField(
                    controller: textFormField,
                    maxLines: 10,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () =>
                            {FocusScope.of(context).requestFocus(FocusNode())},
                        icon: const Icon(Icons.check),
                      ),
                      border: const OutlineInputBorder(),
                      labelText: "Note",
                    ),
                  ),
                ),
                Row(children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Dismiss'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      saveNote(textFormField.text);
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
