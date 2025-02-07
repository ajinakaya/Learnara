import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnara/features/auth/presentation/view/login_view.dart';
import 'package:learnara/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  final TextEditingController fullnameController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _obscureTextPassword = ValueNotifier(true);

  final ValueNotifier<bool> _obscureTextConfirmPassword = ValueNotifier(true);

  File? _img;

  Future<void> checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          // Send image to server
          context.read<RegisterBloc>().add(
            UploadImage(file: _img!),
          );
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  const Text(
                    'Welcome to Learnara',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Create a new account',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.grey[100],
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Choose Profile Picture',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      checkCameraPermission();
                                      _browseImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[600],
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                                    label: const Text(
                                      'Camera',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _browseImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[600],
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    icon: const Icon(Icons.image, color: Colors.white),
                                    label: const Text(
                                      'Gallery',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipOval(
                            child: _img != null
                                ? Image.file(
                              _img!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            )
                                : const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.blue[600],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: fullnameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                      hintText: "Fullname",
                    ),
                    validator: (value) =>
                    value?.isEmpty ?? true ? 'Fullname is required' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.black),
                      hintText: "Email",
                    ),
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
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.verified_user, color: Colors.black),
                      hintText: 'Username',
                    ),
                    validator: (value) =>
                    value?.isEmpty ?? true ? 'Username is required' : null,
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<bool>(
                    valueListenable: _obscureTextPassword,
                    builder: (context, obscureText, child) {
                      return TextFormField(
                        controller: passwordController,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock, color: Colors.black),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              _obscureTextPassword.value = !obscureText;
                            },
                          ),
                        ),
                        validator: (value) {
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
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<bool>(
                    valueListenable: _obscureTextConfirmPassword,
                    builder: (context, obscureText, child) {
                      return TextFormField(
                        controller: confirmPasswordController,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_clock, color: Colors.black),
                          hintText: 'Confirm Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              _obscureTextConfirmPassword.value = !obscureText;
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm password is required';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'By signing you agree to our ',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                      const Text(
                        'Terms of use',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'and ',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                      const Text(
                        'Privacy notice',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 21),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<RegisterBloc>().add(
                            RegisterUser(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text,
                              username: usernameController.text,
                              fullname: fullnameController.text,
                            ),
                          );
                        }
                      },
                      child: const Text("Sign Up"),
                    ),
                  ),
                  const SizedBox(height: 21),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginView()),
                          );
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
