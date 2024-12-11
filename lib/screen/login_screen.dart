import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnara/widget/common_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureTextPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                "assets/images/login1.jpg",
                height: 300,
                width: 300,
              ),
            ),
            const SizedBox(height: 20),

            // Email Field using CommonTextField
            const Text(
              "Email",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 8),
            CommonTextField(
              controller: _emailController,
              hintText: 'Email Address',
              prefixIcon: const Icon(Icons.email, color: Colors.black),
            ),
            const SizedBox(height: 16),

            // Password Field using CommonTextField
            const Text(
              "Password",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 8),
            CommonTextField(
              controller: _passwordController,
              obscureText: _obscureTextPassword,
              hintText: 'Password',
              prefixIcon: const Icon(Icons.lock, color: Colors.black),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    // Toggle the visibility
                    _obscureTextPassword = !_obscureTextPassword;
                  });
                },
                child: Icon(
                  _obscureTextPassword ? Icons.visibility : Icons.visibility_off,
                  size: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Forgot Password Link
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/forget-password");
                },
                child: Text(
                  "Forgot password?",
                  style: TextStyle(color: Colors.blue.shade800),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Log In Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("/dashboard");
              },
              child: const Text(
                "Log In",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 32),

            // Sign Up Option
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.grey.shade800),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/register");
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
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
