import 'package:practice/data/datasources/order_data_source.dart';
import 'package:practice/data/model/order_submit_response.dart';

abstract class IPaymentOrderRepository {
  Future<OrderSubmitResponse> submit(
    String firstName,
    String lastName,
    int postalCode,
    String mobile,
    String address,
    String paymentMethod,
  );
}

class PaymentOrderRepositoryImpl implements IPaymentOrderRepository {
  final RemotePaymentOrderDataSourceImpl remote;

  PaymentOrderRepositoryImpl({required this.remote});
  @override
  Future<OrderSubmitResponse> submit(
    String firstName,
    String lastName,
    int postalCode,
    String mobile,
    String address,
    String paymentMethod,
  ) {
    return remote.submit(
      firstName,
      lastName,
      postalCode,
      mobile,
      address,
      paymentMethod,
    );
  }
}
