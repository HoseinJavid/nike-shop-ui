part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<Product> newestProducts;
  final List<Product> expensiveProducts;
  final List<Product> cheapProducts;
  final List<Product> popularProducts;
  final List<Banner> banners;

  const HomeLoaded({
    required this.newestProducts,
    required this.banners,
    required this.expensiveProducts,
    required this.cheapProducts,
    required this.popularProducts,
  });

  HomeLoaded copyWith({
    List<Product>? products,
    List<Banner>? banners,
    List<Product>? expensiveProducts,
    List<Product>? cheapProducts,
    List<Product>? popularProducts,
  }) {
    return HomeLoaded(
      newestProducts: products ?? newestProducts,
      banners: banners ?? this.banners,
      expensiveProducts: expensiveProducts ?? this.expensiveProducts,
      cheapProducts: cheapProducts ?? this.cheapProducts,
      popularProducts: popularProducts ?? this.popularProducts,
    );
  }

  @override
  List<Object?> get props => [newestProducts];
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
