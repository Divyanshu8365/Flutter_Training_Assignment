import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/helpers/validators.dart';

void main() {
  group('Validator Tests', () {
    group('Email Validator', () {
      test('Empty email returns error', () {
        expect(Validators.validateEmail(''), 'Email is required');
      });

      test('Invalid email returns error', () {
        expect(Validators.validateEmail('invalidemail'), 'Enter a valid email.');
      });

      test('Valid email returns null', () {
        expect(Validators.validateEmail('test@example.com'), null);
      });
    });

    group('Password Validator', () {
      test('Empty password returns error', () {
        expect(Validators.validatePassword(''), 'Password is required');
      });

      test('Short password returns error', () {
        expect(Validators.validatePassword('123'),
            'Password must be at least 6 characters long.');
      });

      test('Valid password returns null', () {
        expect(Validators.validatePassword('123456'), null);
      });
    });
  });
}
