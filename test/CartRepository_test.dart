import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice/data/datasources/cart_data_source.dart';
import 'package:practice/data/repository/cart_repository.dart';

void main() {
  late ICartRepository iCartRepository;
  late ICartDataSource remote;
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

    remote = CartRemoteDataSourceImpl(httpClient: httpClient);
    iCartRepository = CartRepositoryImpl(remote: remote, local: null);
  });

  test('get cart items should succeed (integration test)', () async {
    // Arrange

    // Act
    final result = await iCartRepository.getCartListItems();
    // Assert
    expect(result, isNotNull);
  });

  test('change count cart', () async {
    // Arrange
    const cartItemId = 5;
    const count = 2;

    // Act
    final result = await iCartRepository.changeCartProductCount(
      cartItemId,
      count,
    );

    // Assert
    expect(result, isNotNull);
    expect(result.cartItemId, cartItemId);
    expect(result.count, count);
  });

  test('add to cart', () async {
    // Arrange
    const productId = 1;
    // Act
    final result = await iCartRepository.addToCart(productId);
    // Assert
    expect(result, isNotNull);
  });

  test('remove from cart', () async {
    // Arrange
    const cartItemId = 3;
    // Act
    final result = await iCartRepository.removeCart(cartItemId);
    // Assert
    expect(result, isNotNull);
  });

  test('get cart count', () async {
    // Arrange

    // Act
    final result = await iCartRepository.getCartCount();
    // Assert
    expect(result, isNotNull);
  });
}
