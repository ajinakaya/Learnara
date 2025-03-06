part of 'activity_bloc.dart';

sealed class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object?> get props => [];
}

class FetchFlashcardsEvent extends ActivityEvent {
  final PreferredLanguageEntity? language;

  const FetchFlashcardsEvent({this.language});

  @override
  List<Object?> get props => [language];
}

class FetchQuizzesEvent extends ActivityEvent {
  final PreferredLanguageEntity? language;

  const FetchQuizzesEvent({this.language});

  @override
  List<Object?> get props => [language];
}

class FetchAudioActivitiesEvent extends ActivityEvent {
  final PreferredLanguageEntity? language;

  const FetchAudioActivitiesEvent({this.language});

  @override
  List<Object?> get props => [language];
}