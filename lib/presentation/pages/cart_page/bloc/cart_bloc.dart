import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practice/data/datasources/cart_data_source.dart';
import 'package:practice/data/model/cart_item.dart';
import 'package:practice/data/model/cart_list.dart';
import 'package:practice/data/model/product.dart';
import 'package:practice/data/repository/auth_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final IauthRepository authRepository;
  final ICartDataSource cartDataSource;
  CartBloc(this.authRepository, this.cartDataSource) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      var prevState = state;
      if (event is LoadCart) {
        // emit(CartLoading());
        if (await authRepository.isLogin() == true) {
          //get cart items from api
          var cart = await cartDataSource.getCartListItems();
          var cartCountResponse = await cartDataSource.getCartCount();
          // if cart items or cart count is zero
          if (cartCountResponse.count == 0) {
            emit(CartEmpty());
          } else {
            emit(CartLoaded(cart));
          }
        } else {
          emit(
            CartError(
              "برای مشاهده سبد خرید ابتدا وارد شوید",
              CartErrorType.notLoggedIn,
            ),
          );
        }
      }
      if (event is ChangeCartItemCount) {
        if (prevState is CartLoaded) {
          emit(
            CartLoading(
              type: CartLoadingType.itemCountChange,
              cartItemId: event.cartItemId,
              previousState: prevState,
            ),
          );
         await Future.delayed(Duration(milliseconds: 300));
        }
        if (event.count > 0) {
          await cartDataSource.changeCartProductCount(
            event.cartItemId,
            event.count,
          );
        } else {
          await cartDataSource.removeCart(event.cartItemId);
        }
        var cart = await cartDataSource.getCartListItems();
        emit(CartLoaded(cart));
      }
      if (event is RemoveCartItem) {
        await cartDataSource.removeCart(event.cartItemId);
      }
    });
  }
}
