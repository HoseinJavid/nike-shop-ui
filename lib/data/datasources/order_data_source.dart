import 'package:dio/dio.dart';
import 'package:practice/core/network/validation.dart';
import 'package:practice/data/model/checkout_submit_response.dart';
import 'package:practice/data/model/order_submit_response.dart';

abstract class IOrderDataSource {
  Future<OrderSubmitResponse> submit(
    String firstName,
    String lastName,
    int postalCode,
    String mobile,
    String address,
    String paymentMethod,
  );

  Future<CheckoutSubmitResponse> checkout(int orderId);
}

class RemotePaymentOrderDataSourceImpl with HttpResponseValidation implements IOrderDataSource {
  final Dio httpClient;

  RemotePaymentOrderDataSourceImpl({required this.httpClient});
  @override
  Future<CheckoutSubmitResponse> checkout(int orderId) {
    // TODO: implement checkout
    throw UnimplementedError();
  }

  @override
  Future<OrderSubmitResponse> submit(
    String firstName,
    String lastName,
    int postalCode,
    String mobile,
    String address,
    String paymentMethod,
  ) async{
      var response =await httpClient.post('/order/submit',data: {
        'first_name': firstName,
        'last_name': lastName,
        'postal_code': postalCode,
        'mobile': mobile,
        'address': address,
        'payment_method': paymentMethod,
      });
      validateResposnse(response);
      return OrderSubmitResponse.fromJson(response.data);
  }
}
