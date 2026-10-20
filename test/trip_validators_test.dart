import 'package:flutter_test/flutter_test.dart';
import 'package:go2point/validation/money_input_formatter.dart';
import 'package:go2point/validation/trip_validators.dart';

void main() {
  test(
    'Budget is positive; prices may be zero; money must be finite decimal',
    () {
      expect(TripValidators.budget('0'), isNotNull);
      expect(TripValidators.price('0'), isNull);
      expect(TripValidators.budget('40,50'), isNull);
      expect(TripValidators.price(' 12.99 '), isNull);
      for (final value in ['', '-1', 'NaN', 'Infinity', '1e3', '2.999', '.']) {
        expect(TripValidators.price(value), isNotNull, reason: value);
      }
      expect(TripValidators.requiredText('  '), isNotNull);
    },
  );

  test('Dates reject nonexistent days and enforce inclusive trip bounds', () {
    expect(TripValidators.parseDate('31/02/2028'), isNull);
    expect(TripValidators.parseDate('29/02/2027'), isNull);
    expect(TripValidators.parseDate('29/02/2028'), DateTime(2028, 2, 29));
    expect(TripValidators.date(''), isNotNull);
    for (final date in ['10/03/2028', '15/03/2028']) {
      expect(
        TripValidators.date(
          date,
          notBefore: DateTime(2028, 3, 10),
          notAfter: DateTime(2028, 3, 15),
        ),
        isNull,
      );
    }
    for (final date in ['09/03/2028', '16/03/2028']) {
      expect(
        TripValidators.date(
          date,
          notBefore: DateTime(2028, 3, 10),
          notAfter: DateTime(2028, 3, 15),
        ),
        isNotNull,
      );
    }
  });

  test('Money edits reject invalid paste instead of changing its meaning', () {
    final formatter = MoneyInputFormatter();
    const old = TextEditingValue(text: '40');
    for (final text in ['-10', '40eur', '40.123', '1,2.3']) {
      expect(
        formatter.formatEditUpdate(old, TextEditingValue(text: text)),
        old,
      );
    }
    for (final text in ['', '0', '40,', '40.50']) {
      final edit = TextEditingValue(text: text);
      expect(formatter.formatEditUpdate(old, edit), edit);
    }
  });
}
