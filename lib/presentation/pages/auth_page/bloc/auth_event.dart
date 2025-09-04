part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class ChangeAuthMode extends AuthEvent {
  const ChangeAuthMode();

  @override
  List<Object> get props => [];
}

final class StartSignUpUser extends AuthEvent {
  final String username;
  final String password;
  const StartSignUpUser({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

final class StartLoginUser extends AuthEvent {
  final String username;
  final String password;
  const StartLoginUser({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

enum AuthMode { login, signUp,logout }
