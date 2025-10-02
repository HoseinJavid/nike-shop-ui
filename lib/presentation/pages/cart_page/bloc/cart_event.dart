part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  const LoadCart();

  @override
  List<Object> get props => [];
}

class ChangeCartItemCount extends CartEvent {
  final int cartItemId;
  final int count;
  const ChangeCartItemCount(this.cartItemId, this.count);

  @override
  List<Object> get props => [cartItemId, count];
}

class RemoveCartItem extends CartEvent {
  final int cartItemId;
  const RemoveCartItem(this.cartItemId);

  @override
  List<Object> get props => [cartItemId];
}

class AddCartItem extends CartEvent {
  final int productId;
  const AddCartItem(this.productId);

  @override
  List<Object> get props => [productId];
}

class RefreshCart extends CartEvent {
  const RefreshCart();

  @override
  List<Object> get props => [];
}


