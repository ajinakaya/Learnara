import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('progress'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Progress',
        ),
      ),
    );
  }
}