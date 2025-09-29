class CartAddResponse {
  final int count;
  final int productId;
  final int cartItemId;

  CartAddResponse({
    required this.count,
    required this.productId,
    required this.cartItemId,
  });

  factory CartAddResponse.fromJson(Map<String, dynamic> json) {
    return CartAddResponse(
      count: json['count'],
      productId: json['product_id'],
      cartItemId: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'product_id': productId,
      'cart_item_id': cartItemId,
    };
  }
}
