import 'package:flutter/material.dart';

class NumberFieldHelper {
  static getNumberField(TextEditingController controller, String labelText,
      [int? min, int? max, num? initialVal]) {
    if (initialVal != null && controller.text == "") {
      controller.text = initialVal.toString();
    }
    var containerVal = Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter ' + labelText;
          }
          if (min != null && num.parse(value) < min) {
            return 'number can not be less than ' + min.toString();
          }
          if (max != null && num.parse(value) > max) {
            return 'number can not be more than ' + max.toString();
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
