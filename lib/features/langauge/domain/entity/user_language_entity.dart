import 'package:equatable/equatable.dart';

class UserLanguagePreferenceEntity extends Equatable {
  final String id;
  final String userId;
  final String languageName;
  final String languageImage;

  const UserLanguagePreferenceEntity({
    required this.id,
    required this.userId,
    required this.languageName,
    required this.languageImage,
  });



  @override
  List<Object> get props => [id, userId, languageName, languageImage];
}