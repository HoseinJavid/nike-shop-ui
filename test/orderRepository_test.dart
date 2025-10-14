import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice/core/common/result.dart';
import 'package:practice/core/error/m_exeption.dart';
import 'package:practice/data/datasources/cart_data_source.dart';
import 'package:practice/data/datasources/order_data_source.dart';
import 'package:practice/data/repository/cart_repository.dart';
import 'package:practice/data/repository/payment_order_repository.dart';

void main() {
  late IPaymentOrderRepository orderRepository;
  late RemotePaymentOrderDataSourceImpl remote;
  late Dio httpClient;

  setUp(() async {
    httpClient = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8085/api/v1',
        validateStatus: (status) => true,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imhvc2VpbkBnbWFpbC5jb20iLCJpYXQiOjE3NTI0MDA1NDksImlzcyI6Im5pa2UtYXBpIn0.xYlgDVKN_v0SB_Tr_JxmjZJprWIktuY_UOPKEB9Et7k',
        },
      ),
    );

    remote = RemotePaymentOrderDataSourceImpl(httpClient: httpClient);
    orderRepository = PaymentOrderRepositoryImpl(remote: remote);
  });

  test('with online payment method', () async {
    // Arrange

    // Act
    try {
      final result = await orderRepository.submit(
        'Hossein',
        'Nik',
        12345,
        '1234567890',
        'Tehran, Iran',
        'online',
      );
      // Assert
      expect(result, isNotNull);
    } catch (e) {
      if (e is ValidationException) {
        print(e.errors);
      }
    }
  });

  test('with delivery payment method', () async {});
}
