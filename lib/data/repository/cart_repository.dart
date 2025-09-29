import 'package:practice/data/datasources/cart_data_source.dart';
import 'package:practice/data/model/cart_add_response.dart';
import 'package:practice/data/model/cart_change_count_response.dart';
import 'package:practice/data/model/cart_count_response.dart';
import 'package:practice/data/model/cart_list.dart';
import 'package:practice/data/model/cart_remove_response.dart';

abstract class ICartRepository extends ICartDataSource {}

class CartRepositoryImpl implements ICartRepository {
  final ICartDataSource remote;
  final ICartDataSource? local;

  CartRepositoryImpl({required this.remote, required this.local});

  @override
  Future<CartAddResponse> addToCart(int productId) {
    return remote.addToCart(productId);
  }

  @override
  Future<CartRemoveResponse> removeCart(int cartItemId) {
    return remote.removeCart(cartItemId);
  }

  @override
  Future<CartChangeCountResponse> changeCartProductCount(
    int cartItemId,
    int count,
  ) {
    return remote.changeCartProductCount(cartItemId, count);
  }

  @override
  Future<CartList> getCartListItems() {
    return remote.getCartListItems();
  }

  @override
  Future<CartCountResponse> getCartCount() {
    return remote.getCartCount();
  }
}
