part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  final AuthMode authMode;
  const AuthState(this.authMode);

  @override
  List<Object> get props => [authMode];
}

final class AuthInitial extends AuthState {
  const AuthInitial(super.authMode);

  @override
  List<Object> get props => [authMode];
}

final class ChangedAuthMode extends AuthState {
  const ChangedAuthMode(super.authMode);

  @override
  List<Object> get props => [authMode];
}

final class AuthSuccess extends AuthState {
  const AuthSuccess(super.authMode);
}

final class AuthError extends AuthState {
  final String message;
  final DateTime timestamp = DateTime.now();

  AuthError(this.message, super.authMode);

  @override
  List<Object> get props => [message, authMode, timestamp];
}

final class AuthLoading extends AuthState {
  const AuthLoading(super.authMode);

  @override
  List<Object> get props => [authMode];
}
