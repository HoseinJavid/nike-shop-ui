class CartCountResponse {
  final int count;
  CartCountResponse({required this.count});

  factory CartCountResponse.fromJson(Map<String, dynamic> json) {
    return CartCountResponse(
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
    };
  }
}