import 'package:flutter/material.dart';

class Utility {
  static bool hasValue(String? text) {
    return text == null || text.isEmpty;
  }

  static Color getValidationColorPackingListName(String? text) {
    return validatePackingListName(text) ? Colors.blue : Colors.red;
  }

  static bool validatePackingListName(String? text) {
    return hasValue(text) && text!.length > 6;
  }

  static String? getValidationTextPackingListName(String? text) {
    if (Utility.hasValue(text)) {
      return 'Please enter a list name';
    }
    if (!Utility.validatePackingListName(text)) {
      return 'Please enter a list name longer than 6 char';
    }
    return null;
  }
}

