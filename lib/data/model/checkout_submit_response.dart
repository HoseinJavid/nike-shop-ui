class CheckoutSubmitResponse {
  final int payblePrice;
  final String paymentStatus;
  final int purchaseSuccess;

  CheckoutSubmitResponse({
    required this.payblePrice,
    required this.paymentStatus,
    required this.purchaseSuccess,
  });

  factory CheckoutSubmitResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutSubmitResponse(
      payblePrice: json['payble_price'],
      paymentStatus: json['payment_status'],
      purchaseSuccess: json['purchase_success'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payble_price': payblePrice,
      'payment_status': paymentStatus,
      'purchase_success': purchaseSuccess,
    };
  }
}
