import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice/data/datasources/product_data_source.dart';
import 'package:practice/data/model/product.dart';
import 'package:practice/data/repository/product_repository.dart';

void main() {
  late ProductRepositoryImpl productRepository;
  late IProductDataSource remote;
  // late IProductDataSource local;
  late Dio httpClient;

  setUp(() {
    httpClient = Dio(BaseOptions(baseUrl: 'http://localhost:8085/api/v1'));
    remote = ProductRemoteDataSourceImpl(httpClient: httpClient);
    // local = ProductLocalDataSourceImpl();
    productRepository = ProductRepositoryImpl(remote: remote, local: null);
  });

  test('fetchProducts returns a list of products', () async {
    final products = await productRepository.getProducts(0);
    expect(products, isA<List<Product>>());
    expect(products.isNotEmpty, true);
  });
}
