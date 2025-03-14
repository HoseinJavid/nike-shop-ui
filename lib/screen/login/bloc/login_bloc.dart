import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  //previus state
  LoginState _previusStateTmp = LoginPassFildNotSecure();

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      if (event is ChangeSecureFildPassEvent) {
        if (_previusStateTmp is LoginPassFildNotSecure) {
          _previusStateTmp = LoginPassFildSecure();
          emit(LoginPassFildNotSecure());
        } else if (_previusStateTmp is LoginPassFildSecure) {
          _previusStateTmp = LoginPassFildNotSecure();
          emit(LoginPassFildSecure());
        }
      }
    });
  }
}
