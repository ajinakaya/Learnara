part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String fullname;
  final String email;
  final String username;
  final String password;

  const RegisterUser({
    required this.context,
    required this.fullname,
    required this.email,
    required this.username,
    required this.password,
  });
}
