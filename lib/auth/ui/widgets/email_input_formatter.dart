import 'package:flutter/services.dart';

class EmailMaskTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newMaskedText = '';
    int index = 0;
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (emailRegex.hasMatch(newValue.text)) {
      newMaskedText = newValue.text;
    } else if (oldValue.text != newValue.text) {
      for (int i = 0; i < newValue.text.length; i++) {
        if (emailRegex.hasMatch(newMaskedText)) {
          break;
        }
        if (newValue.text[i].contains(emailRegex)) {
          newMaskedText += newValue.text[i];
        }
      }
    } else {
      newMaskedText = newValue.text;
    }

    index = newMaskedText.length;

    return TextEditingValue(
      text: newMaskedText,
      selection: TextSelection.collapsed(offset: index),
    );
  }
}