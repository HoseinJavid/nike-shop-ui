part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<Product> products;
  const CartLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class CartError extends CartState {
  final String message;
  final CartErrorType type;
  const CartError(this.message, this.type);

  @override
  List<Object> get props => [message];
}

final class CartEmpty extends CartState {}

final class CartItemAdded extends CartState {}

final class CartItemRemoved extends CartState {}

final class CartItemUpdated extends CartState {}

enum CartErrorType { notLoggedIn, networkError, unknown }
