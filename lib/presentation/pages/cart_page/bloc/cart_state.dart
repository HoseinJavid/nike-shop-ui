part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {
  final CartLoadingType type;
  final int? cartItemId;
  final CartLoaded? previousState;
  const CartLoading({
    this.type = CartLoadingType.defult,
    this.cartItemId,
    this.previousState,
  });

  @override
  List<Object> get props => [type];
}

final class CartLoaded extends CartState {
  final CartList cartList;
  const CartLoaded(this.cartList);

  @override
  List<Object> get props => [cartList];
}

final class CartError extends CartState implements AppError {
  @override
  final String message;
  final CartErrorType type;
  const CartError(this.message, this.type);

  @override
  List<Object> get props => [message];
}

final class CartEmpty extends CartState {}

final class CartItemAdded extends CartState {
  @override
  List<Object> get props => super.props;
}

// final class CartItemCountRemoved extends CartState {}

// final class CartItemUpdated extends CartState {}

enum CartErrorType { notLoggedIn, networkError, unknown }

enum CartLoadingType { defult, itemCountChange }
