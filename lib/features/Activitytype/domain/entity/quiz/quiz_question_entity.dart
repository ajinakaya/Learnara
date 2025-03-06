import 'package:equatable/equatable.dart';

class QuizQuestion extends Equatable {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String? explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.explanation,
  });

  @override
  List<Object?> get props => [
    question,
    options,
    correctAnswer,
    explanation,
  ];
}