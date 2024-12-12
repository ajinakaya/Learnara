import 'package:flutter/material.dart';
import 'package:learnara/widget/common_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureTextPassword = true;

  final String storedEmail = "user@gmail.com";
  final String storedPassword = "Password123";

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Email validation function
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Password validation function
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  // Function to handle login
  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      final password = _passwordController.text;

      if (email == storedEmail && password == storedPassword) {
        print("Login Successful!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Successful!")),
        );
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        print("Incorrect email or password!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Incorrect email or password")),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
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
                validator: _validateEmail,
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
                    _obscureTextPassword ? Icons.visibility : Icons
                        .visibility_off,
                    size: 20.0,
                    color: Colors.black,
                  ),
                ),
                validator: _validatePassword,
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
                  backgroundColor: Colors.black.withOpacity(0.75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _handleLogin,
                child: const Text(
                  "Log In",
                  style: TextStyle(fontSize: 18, color: Colors.white),
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
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  }

