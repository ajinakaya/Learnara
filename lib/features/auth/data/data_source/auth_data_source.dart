import 'dart:io';

import 'package:learnara/features/auth/domain/entity/auth_entity.dart';



abstract interface class IAuthDataSource {
  Future<String> loginuser(String username, String password);

  Future<void> registeruser(AuthEntity user);

  Future<AuthEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);
}
