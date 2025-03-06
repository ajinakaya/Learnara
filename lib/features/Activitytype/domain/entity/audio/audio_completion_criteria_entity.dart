

import 'package:equatable/equatable.dart';

class AudioCompletionCriteria extends Equatable {
  final int listenPercentage;
  final String type; // Keep the type field for clarity

  const AudioCompletionCriteria({
    this.listenPercentage = 90,
    this.type = 'percentage', // Default type
  });

  @override
  List<Object?> get props => [listenPercentage, type];
}