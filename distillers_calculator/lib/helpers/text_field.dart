import 'package:flutter/material.dart';

class TextFieldHelper {
  static getTextField(
      TextEditingController controller, String labelText, String initialVal) {
    if (controller.text == "") {
      controller.text = initialVal.toString();
    }
    var containerVal = Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $labelText';
          }

          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: controller.clear,
            icon: const Icon(Icons.clear),
          ),
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );

    return containerVal;
  }
}
