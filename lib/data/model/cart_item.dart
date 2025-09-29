import 'package:practice/data/model/product.dart';

class CartItem {
  final int id;
  final int count;
  final Product product;

  CartItem({required this.id, required this.count, required this.product});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count': count,
      'product': product.toJson(),
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {

    return CartItem(
      id: json['cart_item_id'],
      count: json['count'],
      product: Product.fromJson(json['product']),
    );
  }
}
