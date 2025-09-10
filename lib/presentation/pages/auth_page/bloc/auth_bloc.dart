import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practice/core/error/m_exeption.dart';
import 'package:practice/data/model/auth_info.dart';
import 'package:practice/data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IauthRepository repository;
  AuthMode authmode = AuthMode.login;

  AuthBloc(this.repository) : super(AuthInitial(AuthMode.login)) {
    on<AuthEvent>((event, emit) async {
      if (event is ChangeAuthMode) {
        switch (authmode) {
          case AuthMode.signUp:
            authmode = AuthMode.login;
            emit(ChangedAuthMode(authmode));
            break;
          case AuthMode.login:
            authmode = AuthMode.signUp;
            emit(ChangedAuthMode(authmode));
            break;
          case AuthMode.logout:
            // TODO: Handle this case.
            throw UnimplementedError();
        }
      } else if (event is StartLoginUser) {
        try {
          emit(AuthLoading(authmode));
          await repository.login(event.username, event.password);
          emit(AuthSuccess(authmode));
        } catch (e) {
          if (e is ValidationException) {
            emit(AuthError('نام کاربری یا رمز عبور اشتباه است', authmode));
          } else if (e is ServerException) {
            emit(AuthError('خطا در سرور', authmode));
          } else if (e is UnauthorizedException) {
            emit(AuthError('خطای اعتبار سنجی', authmode));
          } else if (e is NetworkException) {
            emit(AuthError('خطا در اتصال به اینترنت', authmode));
          } else {
            emit(AuthError('خطای نامشخص', authmode));
          }
        }
      } else if (event is StartSignUpUser) {
        try {
          emit(AuthLoading(authmode));
          await repository.signUp(event.username, event.password);
          emit(AuthSuccess(authmode));
        } catch (e) {
          if (e is UserAlreadyExistsException) {
            emit(AuthError('کاربر با این نام کاربری وجود دارد', authmode));
          } else if (e is ServerException) {
            emit(AuthError('خطا در سرور', authmode));
          } else if (e is NetworkException) {
            emit(AuthError('خطا در اتصال به اینترنت', authmode));
          } else if (e is ValidationException) {
            emit(AuthError('خطای اعتبارسنجی', authmode));
          } else {
            emit(AuthError('خطای نامشخص', authmode));
          }
        }
      } else if (event is AuthInitial) {}
    });
  }
}
