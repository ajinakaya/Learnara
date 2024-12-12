
import 'package:flutter/material.dart';
import 'package:learnara/screen/dashboard.dart';
import 'package:learnara/screen/login_screen.dart';
import 'package:learnara/screen/onboarding.dart';
import 'package:learnara/screen/register_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/onboarding',
      routes: {
        '/onboarding':(context) => const Onboarding(),
        '/login':(context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const Dashbaord(),

      },


    );
  }
}