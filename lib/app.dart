
import 'package:flutter/material.dart';
import 'package:flutter_app/view/arithmetic_view.dart';
import 'package:flutter_app/view/first_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ArithmeticView(),
    );
  }
}