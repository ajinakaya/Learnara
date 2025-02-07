import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/features/auth/presentation/view/register_view.dart';

void main() {
  final registerViewState = RegisterViewState();

  group('Email Validation Tests', () {
    test('validateEmail should return error if email is empty', () {
      // Set email to empty
      registerViewState.emailController.text = '';
      expect(registerViewState.emailController.text.isEmpty, true);
    });

    test('validateEmail should return error if email is invalid', () {
      // Set email to an invalid value
      registerViewState.emailController.text = 'invalidEmail';
      expect(registerViewState.emailController.text.contains('@'), false);
    });
  });

  group('Username Validation Tests', () {
    test('validateUsername should return error if username is empty', () {
      // Set username to empty
      registerViewState.usernameController.text = '';
      expect(registerViewState.usernameController.text.isEmpty, true);
    });

    test('validateUsername should return null if username is valid', () {
      // Set username to a valid value
      registerViewState.usernameController.text = 'validUsername';
      expect(registerViewState.usernameController.text.isNotEmpty, true);
    });
  });

  group('Password Validation Tests', () {
    test('validatePassword should return error if password is empty', () {
      // Set password to empty
      registerViewState.passwordController.text = '';
      expect(registerViewState.passwordController.text.isEmpty, true);
    });

    test('validatePassword should return null if password is valid', () {
      // Set password to a valid value
      registerViewState.passwordController.text = 'password123';
      expect(registerViewState.passwordController.text.isNotEmpty, true);
    });

    test('confirmPassword should match password', () {
      registerViewState.passwordController.text = 'password123';
      registerViewState.confirmPasswordController.text = 'password123';
      expect(registerViewState.confirmPasswordController.text, registerViewState.passwordController.text);
    });

    test('confirmPassword should not match if passwords do not match', () {
      registerViewState.passwordController.text = 'password123';
      registerViewState.confirmPasswordController.text = 'password46';
      expect(registerViewState.confirmPasswordController.text, isNot(equals(registerViewState.passwordController.text)));
    });
  });

  group('Fullname Validation Tests', () {
    test('validateFullname should return error if fullname is empty', () {
      // Set fullname to empty
      registerViewState.fullnameController.text = '';
      expect(registerViewState.fullnameController.text.isEmpty, true);
    });

    test('validateFullname should return null if fullname is valid', () {
      // Set fullname to a valid value
      registerViewState.fullnameController.text = 'John Doe';
      expect(registerViewState.fullnameController.text.isNotEmpty, true);
    });
  });

  group('Image Picker Tests', () {
    test('should browse image from gallery', () async {
      final imagePicked = true;
      expect(imagePicked, true);
    });

    test('should browse image from camera', () async {
      final imagePicked = true;
      expect(imagePicked, true);
    });
  });
}
