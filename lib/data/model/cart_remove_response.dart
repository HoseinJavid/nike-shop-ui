class CartRemoveResponse {
  final String message;
  CartRemoveResponse({required this.message});

  factory CartRemoveResponse.fromJson(Map<String, dynamic> json) {
    return CartRemoveResponse(
      message: json['message'],
    );
  } 

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }

  
}