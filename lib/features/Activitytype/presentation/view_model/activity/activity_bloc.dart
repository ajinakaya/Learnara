import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnara/features/Activitytype/domain/entity/audio/audio_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/flashcard_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_entity.dart';
import 'package:learnara/features/Activitytype/domain/usecase/activity_usecase.dart';

import 'package:learnara/features/langauge/domain/entity/language_entity.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final GetAllFlashcardsUseCase _getAllFlashcardsUseCase;
  final GetAllQuizzesUseCase _getAllQuizzesUseCase;
  final GetAllAudioActivitiesUseCase _getAllAudioActivitiesUseCase;

  ActivityBloc({
    required GetAllFlashcardsUseCase getAllFlashcardsUseCase,
    required GetAllQuizzesUseCase getAllQuizzesUseCase,
    required GetAllAudioActivitiesUseCase getAllAudioActivitiesUseCase,
  })  : _getAllFlashcardsUseCase = getAllFlashcardsUseCase,
        _getAllQuizzesUseCase = getAllQuizzesUseCase,
        _getAllAudioActivitiesUseCase = getAllAudioActivitiesUseCase,
        super(ActivityState.initial()) {

    // Fetch Flashcards
    on<FetchFlashcardsEvent>((event, emit) async {
      emit(state.copyWith(flashcardsStatus: ActivityStatus.loading));

      final result = await _getAllFlashcardsUseCase(
          ActivityFilterParams(language: event.language?.languageName)
      );

      result.fold(
              (failure) => emit(state.copyWith(
              flashcardsStatus: ActivityStatus.error,
              errorMessage: failure.toString()
          )),
              (flashcards) => emit(state.copyWith(
              flashcardsStatus: ActivityStatus.loaded,
              flashcards: flashcards
          ))
      );
    });

    // Fetch Quizzes
    on<FetchQuizzesEvent>((event, emit) async {
      emit(state.copyWith(quizzesStatus: ActivityStatus.loading));

      final result = await _getAllQuizzesUseCase(
          ActivityFilterParams(language: event.language?.languageName)
      );

      result.fold(
              (failure) => emit(state.copyWith(
              quizzesStatus: ActivityStatus.error,
              errorMessage: failure.toString()
          )),
              (quizzes) => emit(state.copyWith(
              quizzesStatus: ActivityStatus.loaded,
              quizzes: quizzes
          ))
      );
    });

    // Fetch Audio Activities
    on<FetchAudioActivitiesEvent>((event, emit) async {
      emit(state.copyWith(audioActivitiesStatus: ActivityStatus.loading));

      final result = await _getAllAudioActivitiesUseCase(
          ActivityFilterParams(language: event.language?.languageName)
      );

      result.fold(
              (failure) => emit(state.copyWith(
              audioActivitiesStatus: ActivityStatus.error,
              errorMessage: failure.toString()
          )),
              (audioActivities) => emit(state.copyWith(
              audioActivitiesStatus: ActivityStatus.loaded,
              audioActivities: audioActivities
          ))
      );
    });
  }
}