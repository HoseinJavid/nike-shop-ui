part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeLoadStart extends HomeEvent {
  const HomeLoadStart();

  @override
  List<Object?> get props => [];
}
