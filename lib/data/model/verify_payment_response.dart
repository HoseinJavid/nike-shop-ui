class VerifyPaymentResponse {
  final String status;
  final String message;
  final String transactionId;

  VerifyPaymentResponse({
    required this.status,
    required this.message,
    required this.transactionId,
  });

  factory VerifyPaymentResponse.fromJson(Map<String, dynamic> json) {
    return VerifyPaymentResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      transactionId: json['transaction_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'transaction_id': transactionId,
    };
  }
}