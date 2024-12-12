import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/common_text_field.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  // Booleans to track password visibility for both fields
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              'Welcome to Learnara',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10.0),

            // Subtitle text
            Text(
              'Create a new account',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 40.0),

            // Fullname input field
            CommonTextField(
              controller: _fullnameController,
              keyboardType: TextInputType.name,
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
                size: 22.0,
              ),
              hintText: "Fullname",
            ),
            const SizedBox(height: 20), // Increased gap

            // Email input field
            CommonTextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
                size: 22.0,
              ),
              hintText: "Email",
            ),
            const SizedBox(height: 20), // Increased gap

            // Username input field
            CommonTextField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              prefixIcon: Icon(
                Icons.verified_user,
                color: Colors.black,
                size: 22.0,
              ),
              hintText: 'Username',
            ),
            const SizedBox(height: 20), // Increased gap

            // Password input field with visibility toggle
            CommonTextField(
              controller: _passwordController,
              obscureText: _obscureTextPassword,
              prefixIcon: const Icon(
                Icons.lock,
                size: 22.0,
                color: Colors.black,
              ),
              hintText: 'Password',
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureTextPassword = !_obscureTextPassword;
                  });
                },
                child: Icon(
                  _obscureTextPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  size: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20), // Increased gap

            // Confirm password input field with visibility toggle
            CommonTextField(
              controller: _confirmPasswordController,
              obscureText: _obscureTextConfirmPassword,
              prefixIcon: const Icon(
                Icons.lock_clock,
                size: 22.0,
                color: Colors.black,
              ),
              hintText: 'Confirm Password',
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
                  });
                },
                child: Icon(
                  _obscureTextConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  size: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20), // Gap before terms text

            // Terms and Privacy Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'By signing you agree to our ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'Terms of use',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'and ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'Privacy notice',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 21), // Gap before Sign Up button

            // Sign Up button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(

                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 20)),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 15),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
