import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:learnara/core/network/api_service.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';
import 'package:learnara/features/langauge/domain/usecase/get_all_languages_usecase.dart';
import 'package:learnara/features/langauge/domain/usecase/get_user_preferred_language_usecase.dart';
import 'package:learnara/features/langauge/domain/usecase/set_user_preferred_language_usecase.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetAllLanguagesUseCase _getAllLanguagesUseCase;
  final SetUserPreferredLanguageUseCase _setUserPreferredLanguageUseCase;
  final GetUserPreferredLanguageUseCase _getUserPreferredLanguageUseCase;
  final ApiService _apiService;

  LanguageBloc({
    required GetAllLanguagesUseCase getAllLanguagesUseCase,
    required SetUserPreferredLanguageUseCase setUserPreferredLanguageUseCase,
    required GetUserPreferredLanguageUseCase getUserPreferredLanguageUseCase,
    required ApiService apiService, // This parameter is now properly defined
  }) : _getAllLanguagesUseCase = getAllLanguagesUseCase,
        _setUserPreferredLanguageUseCase = setUserPreferredLanguageUseCase,
        _getUserPreferredLanguageUseCase = getUserPreferredLanguageUseCase,
        _apiService = apiService,
        super(LanguageState.initial()) {
    on<LoadLanguages>(_onLoadLanguages);
    on<SetUserLanguage>(_onSetUserLanguage);
    on<GetUserLanguage>(_onGetUserLanguage);
    on<SetLanguageToken>(_onSetLanguageToken);
  }

  Future<void> _onLoadLanguages(
      LoadLanguages event, Emitter<LanguageState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllLanguagesUseCase.call();
    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
          (languages) => emit(state.copyWith(
        isLoading: false,
        languages: languages,
        error: null,
      )),
    );
  }

  Future<void> _onSetUserLanguage(
      SetUserLanguage event, Emitter<LanguageState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _setUserPreferredLanguageUseCase.call(
      SetUserPreferredLanguageParams(userLanguage: event.languagePreference),
    );
    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
          (_) {
        emit(state.copyWith(
          isLoading: false,
          userLanguagePreference: event.languagePreference,
          error: null,
        ));
      },
    );
  }

  Future<void> _onGetUserLanguage(
      GetUserLanguage event, Emitter<LanguageState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getUserPreferredLanguageUseCase.call(
      GetUserPreferredLanguageParams(userId: event.userId),
    );
    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
          (userLanguage) => emit(state.copyWith(
        isLoading: false,
        userLanguagePreference: userLanguage,
        error: null,
      )),
    );
  }

  void _onSetLanguageToken(
      SetLanguageToken event, Emitter<LanguageState> emit) {
    _apiService.setToken(event.token);

  }
}