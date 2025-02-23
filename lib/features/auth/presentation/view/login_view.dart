import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnara/features/auth/presentation/view/register_view.dart';
import 'package:learnara/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';


class LoginView extends StatefulWidget {
  final PreferredLanguageEntity? selectedLanguage;
  const LoginView({Key? key, this.selectedLanguage}) : super(key: key);


  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureTextPassword = true;

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Email validation function
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Password validation function
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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

              // Email Field
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  prefixIcon: const Icon(Icons.email, color: Colors.black),
                ),
                validator: validateEmail,
              ),
              const SizedBox(height: 16),

              // Password Field
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureTextPassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.black),
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
                validator: validatePassword,
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(
                      LoginUserEvent(
                        context: context,
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    );

                  }
                },
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
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 13,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<LoginBloc>().add(
                        NavigateRegisterScreenEvent(
                          destination:  RegisterView(),
                          context: context,
                        ),
                      );
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
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
