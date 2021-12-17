import 'package:flutter/material.dart';

class NumberField {
  static getNumberField(TextEditingController controller, String labelText) {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20),
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter ' + labelText;
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
  }
}
