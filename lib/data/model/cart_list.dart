import 'package:practice/data/model/cart_Item.dart';

class CartList {
  List<CartItem> cartItems;
  final int totalPrice;
  final int payablePrice;
  final int shippingCost;

  CartList({
    required this.cartItems,
    required this.totalPrice,
    required this.payablePrice,
    required this.shippingCost,
  });

  Map<String, dynamic> toJson() {
    return {
      'cart_items': cartItems.map((item) => item.toJson()).toList(),
      'total_price': totalPrice,
      'payable_price': payablePrice,
      'shipping_cost': shippingCost,
    };
  }

  factory CartList.fromJson(Map<String, dynamic> json) {
    var cartItemsFromJson = json['cart_items'] as List;
    List<CartItem> cartItemList = [];

    for (var cartItem in cartItemsFromJson) {
      cartItemList.add(CartItem.fromJson(cartItem));
    }
    return CartList(
      cartItems: cartItemList,
      totalPrice: json['total_price'],
      payablePrice: json['payable_price'],
      shippingCost: json['shipping_cost'],
    );
  }
}
