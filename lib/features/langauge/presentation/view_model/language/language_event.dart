part of 'language_bloc.dart';

@immutable
sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

final class LoadLanguages extends LanguageEvent {}

final class SetUserLanguage extends LanguageEvent {
  final UserLanguagePreferenceEntity languagePreference;

  const SetUserLanguage(this.languagePreference);

  @override
  List<Object> get props => [languagePreference];
}

final class GetUserLanguage extends LanguageEvent {
  final String userId;

  const GetUserLanguage(this.userId);

  @override
  List<Object> get props => [userId];
}

final class SetLanguageToken extends LanguageEvent {
  final String token;

  const SetLanguageToken(this.token);

  @override
  List<Object> get props => [token];
}