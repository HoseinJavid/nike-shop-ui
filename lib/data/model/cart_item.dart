import 'package:practice/data/model/product.dart';

class CartItem {
  final int id;
  final int count;
  final List<Product> products;

  CartItem({required this.id, required this.count, required this.products});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count': count,
      'product': products.map((product) => product.toJson()).toList(),
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    var productsFromJson = json['products'] as List;
    List<Product> productList = productsFromJson
        .map((i) => Product.fromJson(i))
        .toList();

    return CartItem(
      id: json['id'],
      count: json['count'],
      products: productList,
    );
  }
}
