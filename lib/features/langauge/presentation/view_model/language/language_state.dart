part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final List<PreferredLanguageEntity> languages;
  final UserLanguagePreferenceEntity? userLanguagePreference;
  final bool isLoading;
  final String? error;
  final String? token;

  const LanguageState({
    required this.languages,
    this.userLanguagePreference,
    required this.isLoading,
    this.error,
    this.token,
  });

  factory LanguageState.initial() {
    return const LanguageState(
      languages: [],
      userLanguagePreference: null,
      isLoading: false,
      token: null,
    );
  }

  LanguageState copyWith({
    List<PreferredLanguageEntity>? languages,
    UserLanguagePreferenceEntity? userLanguagePreference,
    bool? isLoading,
    String? error,
    String? token,

  }) {
    return LanguageState(
      languages: languages ?? this.languages,
      userLanguagePreference: userLanguagePreference ?? this.userLanguagePreference,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [languages, userLanguagePreference, isLoading, error,token];
}