import 'package:equatable/equatable.dart';

class CardData extends Equatable {
  final String front;
  final String back;
  final String? hint;
  final String? example;

  const CardData({
    required this.front,
    required this.back,
    this.hint,
    this.example,
  });

  @override
  List<Object?> get props => [front, back, hint, example];
}