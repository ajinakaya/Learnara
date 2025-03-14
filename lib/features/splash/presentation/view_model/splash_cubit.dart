import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnara/features/onboarding/presentation/view/onboarding.dart';


class SplashCubit extends Cubit<void> {
  SplashCubit() : super(null);

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Onboarding(),
          ),
        );
      }
    });
  }
}
