import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthEntity Tests', () {
    // Test 1: Test the initialization of the AuthEntity
    test('should initialize AuthEntity with the given values', () {
      final authEntity = AuthEntity(
        id: '1',
        fullname: 'John Doe',
        email: 'johndoe@example.com',
        username: 'johndoe',
        password: 'password123',
        image: 'image_url',
        role: 'admin',
      );

      expect(authEntity.id, '1');
      expect(authEntity.fullname, 'John Doe');
      expect(authEntity.email, 'johndoe@example.com');
      expect(authEntity.username, 'johndoe');
      expect(authEntity.password, 'password123');
      expect(authEntity.image, 'image_url');
      expect(authEntity.role, 'admin');
    });

    // Test 2: Test the equality of two AuthEntity instances
    test('should return true when two AuthEntity instances are equal', () {
      final authEntity1 = AuthEntity(
        id: '1',
        fullname: 'John Doe',
        email: 'johndoe@example.com',
        username: 'johndoe',
        password: 'password123',
        image: 'image_url',
        role: 'admin',
      );

      final authEntity2 = AuthEntity(
        id: '1',
        fullname: 'John Doe',
        email: 'johndoe@example.com',
        username: 'johndoe',
        password: 'password123',
        image: 'image_url',
        role: 'admin',
      );

      expect(authEntity1, equals(authEntity2));
    });

    // Test 3: Test equality for instances with different values
    test('should return false when two AuthEntity instances have different values', () {
      final authEntity1 = AuthEntity(
        id: '1',
        fullname: 'John Doe',
        email: 'johndoe@example.com',
        username: 'johndoe',
        password: 'password123',
        image: 'image_url',
        role: 'admin',
      );

      final authEntity2 = AuthEntity(
        id: '2',
        fullname: 'Jane Doe',
        email: 'janedoe@example.com',
        username: 'janedoe',
        password: 'password123',
        image: 'image_url',
        role: 'admin',
      );

      expect(authEntity1, isNot(equals(authEntity2)));
    });

    // Test 4: Test default values (role should default to 'user' if not provided)
    test('should default to "user" for role if not provided', () {
      final authEntity = AuthEntity(
        id: '1',
        fullname: 'John Doe',
        email: 'johndoe@example.com',
        username: 'johndoe',
        password: 'password123',
      );

      expect(authEntity.role, 'user');  // Role should default to 'user'
    });

    // Test 5: Test if the password is not empty
    test('should not have an empty password', () {
      final authEntity = AuthEntity(
        id: '1',
        fullname: 'John Doe',
        email: 'johndoe@example.com',
        username: 'johndoe',
        password: 'password123',
      );

      expect(authEntity.password.isNotEmpty, true);
    });
  });
}
