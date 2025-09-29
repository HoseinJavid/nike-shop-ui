import 'package:dio/dio.dart';
import 'package:practice/core/network/validation.dart';
import 'package:practice/data/model/cart_add_response.dart';
import 'package:practice/data/model/cart_change_count_response.dart';
import 'package:practice/data/model/cart_count_response.dart';
import 'package:practice/data/model/cart_list.dart';
import 'package:practice/data/model/cart_remove_response.dart';

abstract class ICartDataSource {
  Future<CartAddResponse> addToCart(int productId);
  Future<CartRemoveResponse> removeCart(int cartItemId);
  Future<CartChangeCountResponse> changeCartProductCount(
    int cartItemId,
    int count,
  );
  Future<CartList> getCartListItems();
  Future<CartCountResponse> getCartCount();
}

class CartRemoteDataSourceImpl
    with HttpResponseValidation
    implements ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<CartAddResponse> addToCart(int productId) async {
    var response = await httpClient.post(
      '/cart/add',
      data: {'product_id': productId},
    );
    validateResposnse(response);
    return CartAddResponse.fromJson(response.data);
  }

  @override
  Future<CartRemoveResponse> removeCart(int cartItemId) async {
    var response = await httpClient.post(
      '/cart/remove',
      data: {'cart_item_id': cartItemId},
    );
    validateResposnse(response);
    return CartRemoveResponse.fromJson(response.data);
  }

  @override
  Future<CartChangeCountResponse> changeCartProductCount(
    int cartItemId,
    int count,
  ) async {
    var response = await httpClient.post(
      '/cart/changeCount',
      data: {'cart_item_id': cartItemId, 'count': count},
    );
    validateResposnse(response);
    return CartChangeCountResponse.fromJson(response.data);
  }

  @override
  Future<CartList> getCartListItems() async {
    var response = await httpClient.get('/cart/list');
    validateResposnse(response);
    return CartList.fromJson(response.data);
  }

  @override
  Future<CartCountResponse> getCartCount() async {
    var response = await httpClient.get('/cart/count');
    validateResposnse(response);
    return CartCountResponse.fromJson(response.data);
  }
}
