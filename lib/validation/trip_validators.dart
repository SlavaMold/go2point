abstract final class TripValidators {
  static String? requiredText(String? value) =>
      value == null || value.trim().isEmpty ? 'This field is required' : null;

  static double? parseMoney(String? value) =>
      double.tryParse((value ?? '').trim().replaceAll(',', '.'));

  static String? price(String? value) => _money(value, allowZero: true);

  static String? budget(String? value) => _money(value, allowZero: false);

  static String? _money(String? value, {required bool allowZero}) {
    if (requiredText(value) != null) return 'Enter an amount';
    final number = parseMoney(value);
    if (number == null || !number.isFinite) {
      return 'Enter a number with up to 2 decimal places';
    }
    if (allowZero ? number < 0 : number <= 0) {
      return allowZero
          ? 'Price cannot be negative'
          : 'Budget must be greater than 0';
    }
    if (!RegExp(r'^\d+(?:[.,]\d{1,2})?$').hasMatch(value!.trim())) {
      return 'Enter a number with up to 2 decimal places';
    }
    return null;
  }

  static DateTime? parseDate(String? value) {
    final match = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').firstMatch(value ?? '');
    if (match == null) return null;
    final day = int.parse(match[1]!);
    final month = int.parse(match[2]!);
    final year = int.parse(match[3]!);
    final date = DateTime(year, month, day);
    return date.year == year && date.month == month && date.day == day
        ? date
        : null;
  }

  static String? date(
    String? value, {
    DateTime? notBefore,
    DateTime? notAfter,
    String beforeMessage = 'Date is too early',
    String afterMessage = 'Date is too late',
  }) {
    if (requiredText(value) != null) return 'Select a date';
    final date = parseDate(value);
    if (date == null) return 'Use a valid dd/mm/yyyy date';
    if (notBefore != null &&
        date.isBefore(
          DateTime(notBefore.year, notBefore.month, notBefore.day),
        )) {
      return beforeMessage;
    }
    if (notAfter != null &&
        date.isAfter(DateTime(notAfter.year, notAfter.month, notAfter.day))) {
      return afterMessage;
    }
    return null;
  }
}
