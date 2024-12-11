
import 'package:flutter/material.dart';
import 'package:learnara/screen/login_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login':(context) => const LoginScreen(),

      },


    );
  }
}