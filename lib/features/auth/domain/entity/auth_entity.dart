import 'package:equatable/equatable.dart';


class AuthEntity extends Equatable {
  final String? id;
  final String fullname;
  final String email;
  final String? image;
  final String username;
  final String password;
  final String role;

  const AuthEntity({
    this.id,
    required this.fullname,
    required this.email,
    required this.username,
    required this.password,
    this.image,
    this.role = "user",
  });

  @override
  List<Object?> get props =>
      [id,fullname,email,username,password,image,role];
}
