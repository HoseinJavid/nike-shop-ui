part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitialSuccses extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final String massage;
  HomeError({required this.massage});
  
}

final class HomeSucces extends HomeState {
  final List<Product>? products;
  final List<Banner> banners;
  final int sortOptions;

  HomeSucces(this.sortOptions, {required this.products, required this.banners});
}
