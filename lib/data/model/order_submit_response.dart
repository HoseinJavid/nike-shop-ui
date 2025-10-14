class OrderSubmitResponse {
  final int orderId;
  final String bankGatewayUrl;
  final String paymentMethod;

  OrderSubmitResponse({
    required this.orderId,
    required this.bankGatewayUrl,
    required this.paymentMethod,
  });

  factory OrderSubmitResponse.fromJson(Map<String, dynamic> json) {
    return OrderSubmitResponse(
      orderId: json['order_id'],
      bankGatewayUrl: json['bank_gateway_url'] ?? '' ,
      paymentMethod: json['payment_method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'bank_gateway_url': bankGatewayUrl,
      'payment_method': paymentMethod,
    };
  }
}
