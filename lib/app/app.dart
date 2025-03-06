import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnara/app/di/di.dart';
import 'package:learnara/core/theme/app_theme/app_theme.dart';
import 'package:learnara/features/Activitytype/presentation/view_model/activity/activity_bloc.dart';
import 'package:learnara/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:learnara/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:learnara/features/courses/presentation/view_model/course_bloc.dart';
import 'package:learnara/features/langauge/presentation/view_model/language/language_bloc.dart';
import 'package:learnara/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:learnara/features/splash/presentation/view/splash_view.dart';
import 'package:learnara/features/splash/presentation/view_model/splash_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt <SplashCubit>()),
          BlocProvider(create: (_) => getIt <LoginBloc>()),
          BlocProvider(create: (_) => getIt <RegisterBloc>()),
          BlocProvider(create: (_) => getIt <LanguageBloc>()),
          BlocProvider(create: (_) => getIt <ProfileBloc>()),
          BlocProvider(create: (_) => getIt <ActivityBloc>()),
          BlocProvider(create: (_) => getIt <CourseBloc>()),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Learnara',
          theme: AppTheme.getApplicationTheme(),
          home: const SplashView(),
        ));
  }
}