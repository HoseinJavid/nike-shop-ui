part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeLoadProducts extends HomeEvent {
  final int sort;

  const HomeLoadProducts(this.sort);

  @override
  List<Object?> get props => [sort];
}

// class HomeSearchProducts extends HomeEvent {
//   final String searchTerm;

//   const HomeSearchProducts(this.searchTerm);

//   @override
//   List<Object?> get props => [searchTerm];
// }

// class HomeRefresh extends HomeEvent {
//   const HomeRefresh();
// }
