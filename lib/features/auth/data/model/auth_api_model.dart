import  'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:learnara/features/auth/domain/entity/auth_entity.dart';


part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  final String fullname;
  final String email;
  final String username;
  final String? image;
  final String role;
  final String password;

  const AuthApiModel({
    this.id,
    required this.fullname,
    required this.email,
    required this.username,
    required this.image,
    this.role = "user",
    required this.password,
  });

  // auto generates the json values (From Json)
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);


  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      fullname: fullname,
      email: email,
      username: username,
      image: image,
      role: role,
      password: password,
    );
  }
  // From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      fullname: entity.fullname,
      email: entity.email,
      username: entity.username,
      image: entity.image,
      role: entity.role,
      password: entity.password,
    );
  }


  @override
  List<Object?> get props => [
    fullname,
    email,
    username,
    image,
    role,
    password,
  ];
}
