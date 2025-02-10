import 'package:equatable/equatable.dart';

class CompletionCriteria extends Equatable {
  final int cardsReviewed;
  final int minimumCorrect;

  const CompletionCriteria({
    required this.cardsReviewed,
    this.minimumCorrect = 80,
  });

  @override
  List<Object?> get props => [cardsReviewed, minimumCorrect];
}