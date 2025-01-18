import 'package:flutter/cupertino.dart';
import 'package:learnara/app/app.dart';
import 'package:flutter/material.dart';
import 'package:learnara/app/di/di.dart';
import 'package:learnara/core/network/hive_service.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive Database
  await HiveService.init();

  await initDependencies();
  runApp(
    const MyApp(),
  );

}


