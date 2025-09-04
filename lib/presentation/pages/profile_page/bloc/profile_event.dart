part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class LoadProfile extends ProfileEvent {
  @override
  List<Object> get props => [];
}

final class LogoutRequested extends ProfileEvent {
  @override
  List<Object> get props => [];
}

final class LoginRequested extends ProfileEvent {
  @override
  List<Object> get props => [];
}
