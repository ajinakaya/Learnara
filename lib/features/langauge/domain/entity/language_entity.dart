import 'package:equatable/equatable.dart';

class PreferredLanguageEntity extends Equatable {
  final String languageId;
  final String languageName;
  final String languageImage;

  const PreferredLanguageEntity({
    required this.languageId,
    required this.languageName,
    required this.languageImage,
  });

  @override
  List<Object> get props => [languageId, languageName, languageImage];
}
