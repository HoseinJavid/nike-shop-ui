import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practice/data/repository/auth_repository.dart';
import 'package:practice/presentation/pages/auth_page/bloc/auth_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IauthRepository repository;
  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is LoadProfile) {
        emit(ProfileLoaindg());
        if (await repository.isLogin() == true) {
          emit(ProfileLoaded(authMode: AuthMode.login));
        } else {
          emit(ProfileLoaded(authMode: AuthMode.logout));
        }
      } else if (event is LogoutRequested) {
        emit(ProfileLoaindg());
        await repository.signOut();
        emit(ProfileLoaded(authMode: AuthMode.logout));
      }
    });
  }
}
