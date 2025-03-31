part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeStartInit extends HomeEvent {}

final class ChangeSortOption extends HomeEvent {
  final int sortOption;

  ChangeSortOption(this.sortOption);
}
