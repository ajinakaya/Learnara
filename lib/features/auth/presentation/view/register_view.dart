import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../cors/common/common_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  // Booleans to track password visibility for both fields
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Password validation function
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  // Confirm password validation function
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Save user data to registeredUsers map
      final email = _emailController.text;
      final password = _passwordController.text;

      print("Email: $email, Password: $password");

      // Navigate to the login screen
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                'Welcome to Learnara',
                style: TextStyle(
                  fontSize: 30,
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
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Fullname is required' : null,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
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
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Username is required' : null,
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
                validator: _validatePassword,
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
                      _obscureTextConfirmPassword =
                          !_obscureTextConfirmPassword;
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
                validator: _validateConfirmPassword,
              ),
              const SizedBox(height: 20),

              // Terms and Privacy Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'By signing you agree to our ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Terms of use',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
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
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Privacy notice',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
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
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Colors.black.withOpacity(0.75),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 21),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
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
