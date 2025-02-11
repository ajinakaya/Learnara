part of 'activity_bloc.dart';

enum ActivityStatus { initial, loading, loaded, error }

class ActivityState {
  final List<FlashcardEntity> flashcards;
  final List<QuizEntity> quizzes;
  final List<AudioEntity> audioActivities;
  final ActivityStatus flashcardsStatus;
  final ActivityStatus quizzesStatus;
  final ActivityStatus audioActivitiesStatus;
  final String? errorMessage;

  ActivityState({
    required this.flashcards,
    required this.quizzes,
    required this.audioActivities,
    required this.flashcardsStatus,
    required this.quizzesStatus,
    required this.audioActivitiesStatus,
    this.errorMessage,
  });

  ActivityState.initial()
      : flashcards = [],
        quizzes = [],
        audioActivities = [],
        flashcardsStatus = ActivityStatus.initial,
        quizzesStatus = ActivityStatus.initial,
        audioActivitiesStatus = ActivityStatus.initial,
        errorMessage = null;

  ActivityState copyWith({
    List<FlashcardEntity>? flashcards,
    List<QuizEntity>? quizzes,
    List<AudioEntity>? audioActivities,
    ActivityStatus? flashcardsStatus,
    ActivityStatus? quizzesStatus,
    ActivityStatus? audioActivitiesStatus,
    String? errorMessage,
  }) {
    return ActivityState(
      flashcards: flashcards ?? this.flashcards,
      quizzes: quizzes ?? this.quizzes,
      audioActivities: audioActivities ?? this.audioActivities,
      flashcardsStatus: flashcardsStatus ?? this.flashcardsStatus,
      quizzesStatus: quizzesStatus ?? this.quizzesStatus,
      audioActivitiesStatus: audioActivitiesStatus ?? this.audioActivitiesStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}