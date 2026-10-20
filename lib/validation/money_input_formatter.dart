import 'package:flutter/services.dart';

/// Reject the whole edit instead of silently removing invalid characters.
class MoneyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return RegExp(r'^\d*(?:[.,]\d{0,2})?$').hasMatch(newValue.text)
        ? newValue
        : oldValue;
  }
}
