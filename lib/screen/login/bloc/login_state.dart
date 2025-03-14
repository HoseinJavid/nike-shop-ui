part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginPassFildNotSecure extends LoginState {}

final class LoginPassFildSecure extends LoginState {}

