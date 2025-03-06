import 'package:equatable/equatable.dart';

class QuizCompletionCriteria extends Equatable {
  final int passingScore;
  final int attemptsAllowed;

  const QuizCompletionCriteria({
    this.passingScore = 70,
    this.attemptsAllowed = 3,
  });

  @override
  List<Object?> get props => [
    passingScore,
    attemptsAllowed,
  ];
}