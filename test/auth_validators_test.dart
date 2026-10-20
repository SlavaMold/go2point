import 'package:flutter_test/flutter_test.dart';
import 'package:go2point/validation/auth_validators.dart';

void main() {
  test('Name rejects missing or whitespace-only input', () {
    for (final value in [null, '', '   ']) {
      expect(AuthValidators.name(value), 'Name is required');
    }
    expect(AuthValidators.name(' Veaceslav '), isNull);
  });

  test('Email requires a plausible address and ignores surrounding spaces', () {
    for (final value in [null, '', '   ']) {
      expect(AuthValidators.email(value), 'Email is required');
    }
    for (final value in [
      'student',
      'student@',
      '@example.com',
      'a b@example.com',
      'a@b@c.com',
    ]) {
      expect(AuthValidators.email(value), 'Enter a valid email address');
    }
    expect(AuthValidators.email(' student@example.com '), isNull);
  });

  test(
    'Password requires at least six characters without trimming its value',
    () {
      for (final value in [null, '', '      ']) {
        expect(AuthValidators.password(value), 'Password is required');
      }
      expect(
        AuthValidators.password('12345'),
        'Password must be at least 6 characters',
      );
      expect(AuthValidators.password('123456'), isNull);
      expect(AuthValidators.password(' abcde'), isNull);
    },
  );

  test('Confirmation must match the complete password exactly', () {
    expect(
      AuthValidators.confirmPassword('', 'secret'),
      'Please confirm your password',
    );
    expect(
      AuthValidators.confirmPassword('Secret', 'secret'),
      'Passwords do not match',
    );
    expect(
      AuthValidators.confirmPassword('secret ', 'secret'),
      'Passwords do not match',
    );
    expect(AuthValidators.confirmPassword('secret', 'secret'), isNull);
  });
}
