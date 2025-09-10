class CartChangeCountResponse {
  final int productId;
  final int count;
  final int cartItemId;

  CartChangeCountResponse({
    required this.productId,
    required this.count,
    required this.cartItemId,
  });

  factory CartChangeCountResponse.fromJson(Map<String, dynamic> json) {
    return CartChangeCountResponse(
      productId: json['product_id'],
      count: json['count'],
      cartItemId: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'count': count,
      'id': cartItemId,
    };
  }
}
