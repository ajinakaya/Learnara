import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/features/auth/data/model/auth_api_model.dart';
import 'package:learnara/features/auth/domain/entity/auth_entity.dart';

 
void main() {
  const authApiModel = AuthApiModel(
    id: '123',
    email: 'test@example.com',
    image: 'profile.jpg',
    fullname: "John Doe",
    role: 'user',
    username: 'testUser',
    password: 'password123',
  );
 
  const authEntity = AuthEntity(
    id: '123',
    email: 'test@example.com',
    image: 'profile.jpg',
    fullname: "John Doe",
    role: 'user',
    username: 'testUser',
    password: 'password123',
  );
 
  group('AuthApiModel', () {
    test('should convert from JSON correctly', () {
      final json = {
        '_id': '123',
        'email': 'test@example.com',
        'image': 'profile.jpg',
        'fullname': "John Doe",
        'role': 'user',
        'username': 'testUser',
        'password': 'password123',
      };
 
      final model = AuthApiModel.fromJson(json);
      expect(model, authApiModel);
    });
 
    test('should convert to JSON correctly', () {
      final json = authApiModel.toJson();
      expect(json, {
        '_id': '123',
        'email': 'test@example.com',
        'image': 'profile.jpg',
        'fullname': "John Doe",
        'role': 'user',
        'username': 'testUser',
        'password': 'password123',
      });
    });
 
    test('should convert to entity correctly', () {
      final entity = authApiModel.toEntity();
      expect(entity, authEntity);
    });
 
    test('should create model from entity correctly', () {
      final model = AuthApiModel.fromEntity(authEntity);
      expect(model, authApiModel);
    });
 
    test('should support value equality', () {
      final model1 = AuthApiModel.fromEntity(authEntity);
      final model2 = AuthApiModel.fromEntity(authEntity);
      expect(model1, equals(model2));
    });
  });
}
 
 