import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnara/app/share_pref/token_share_pref.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';
import 'package:learnara/features/langauge/presentation/view_model/language/language_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learnara/core/common/snack_bar/my_snackbar.dart';
import 'package:learnara/features/auth/domain/usecase/login_usecase.dart';
import 'package:learnara/features/auth/presentation/view/login_view.dart';
import 'package:learnara/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:learnara/features/home/presentation/view/home_view.dart';
import 'package:learnara/features/home/presentation/view_model/home_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TokenSharedPrefs _tokenSharedPrefs;
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;
  final LoginUseCase _loginUseCase;

  LoginBloc({
    required TokenSharedPrefs tokenSharedPrefs,
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
    required LoginUseCase loginUseCase,
  })  : _tokenSharedPrefs = tokenSharedPrefs,
        _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        _loginUseCase = loginUseCase,
        super(LoginState.initial()) {

    // Navigate to Register Screen
    on<NavigateRegisterScreenEvent>(
          (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _registerBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );

    // Navigate to Home Screen
    on<NavigateHomeScreenEvent>(
          (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _homeCubit,
              child: event.destination,
            ),
          ),
        );
      },
    );

    // Login User
    on<LoginUserEvent>(
          (event, emit) async {
        emit(state.copyWith(isLoading: true));

        final result = await _loginUseCase(
          LoginParams(
            email: event.email,
            password: event.password,
          ),
        );

        result.fold(
              (failure) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
            showMySnackBar(
              context: event.context,
              message: "Invalid Credentials",
              color: Colors.red,
            );
          },
              (token) async {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            showMySnackBar(
              context: event.context,
              message: "Login Successful",
              color: Colors.green,
            );

            // Save token first - this is crucial
            await _tokenSharedPrefs.saveToken(token);

            // Extract user ID from the token
            final userId = await _extractUserIdFromToken(token);
            if (userId != null) {
              await _saveUserId(userId);
            }

            // Get the selected language from the previous screen
            PreferredLanguageEntity? selectedLanguage;
            if (event.context.widget is LoginView) {
              final loginView = event.context.widget as LoginView;
              selectedLanguage = loginView.selectedLanguage;
            }

            // If we have a language selection
            if (selectedLanguage != null) {
              final userLanguageEntity = UserLanguagePreferenceEntity(
                id: selectedLanguage.languageId,
                userId: userId ?? "default_user_id",
                languageName: selectedLanguage.languageName,
                languageImage: selectedLanguage.languageImage,
              );

              // First save locally
              await _saveLanguagePreference(userLanguageEntity);

              event.context.read<LanguageBloc>().add(
                  SetLanguageToken(token)
              );

              // Then update the LanguageBloc with the selected language
              event.context.read<LanguageBloc>().add(
                  SetUserLanguage(userLanguageEntity)
              );
            }
            // If no selected language, try to get saved preference
            else {
              final completeLanguageResult = await _tokenSharedPrefs.getCompleteLanguagePreference();
              completeLanguageResult.fold(
                    (failure) {

                  _tokenSharedPrefs.getUserLanguage().then((simpleLanguageResult) {
                    simpleLanguageResult.fold(
                          (failure) => print("Error retrieving language: ${failure.message}"),
                          (language) async {
                        if (language.isNotEmpty) {
                          final userLanguageEntity = UserLanguagePreferenceEntity(
                            id: "default_id",
                            userId: userId ?? "default_user_id",
                            languageName: language,
                            languageImage: "default_image_path",
                          );

                          // Make sure to set token first
                          event.context.read<LanguageBloc>().add(
                              SetLanguageToken(token)
                          );

                          // Then set language
                          event.context.read<LanguageBloc>().add(
                              SetUserLanguage(userLanguageEntity)
                          );
                        } else {
                          await _tokenSharedPrefs.saveUserLanguage("English");
                        }
                      },
                    );
                  });
                },
                    (completeLanguage) {
                  // Set token first
                  event.context.read<LanguageBloc>().add(
                      SetLanguageToken(token)
                  );

                  // Then use the complete language entity
                  event.context.read<LanguageBloc>().add(
                      SetUserLanguage(completeLanguage)
                  );
                },
              );
            }

            // Navigate to home screen
            add(
              NavigateHomeScreenEvent(
                context: event.context,
                destination: HomeView(),
              ),
            );
          },
        );
      },
    );
  }

  // Helper method to extract user ID from token
  Future<String?> _extractUserIdFromToken(String token) async {

    try {

      final parts = token.split('.');
      if (parts.length < 2) return null;
      final payload = parts[1];
      final padded = payload.padRight(4 * ((payload.length + 3) ~/ 4), '=');
      final decoded = utf8.decode(base64Url.decode(padded));
      final Map<String, dynamic> json = jsonDecode(decoded);
      return json['_id'] as String?;
    } catch (e) {
      print("Error extracting user ID from token: $e");
      return null;
    }
  }

  // Save user ID to SharedPreferences
  Future<void> _saveUserId(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId);
    } catch (e) {
      print("Error saving user ID: $e");
    }
  }

  // Helper method to save language preference locally
  Future<void> _saveLanguagePreference(UserLanguagePreferenceEntity language) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedLanguageId', language.id);
      await prefs.setString('selectedLanguageName', language.languageName);
      await prefs.setString('selectedLanguageImage', language.languageImage);

      // Also save to token shared prefs
      await _tokenSharedPrefs.saveUserLanguage(language.languageName);
      // Save complete language preference
      await _tokenSharedPrefs.saveCompleteLanguagePreference(language);
    } catch (e) {
      print("Error saving language preference: $e");
    }
  }
}