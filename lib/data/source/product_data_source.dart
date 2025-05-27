import 'package:dio/dio.dart';
import 'package:nike_ecommerce/common/app_constants.dart';

import '../model/product.dart';

abstract class ImplRemoteProductDataSource {
  Future<List<Product>> getProducts({int sortOptions});
  Future<List<Product>> search(String keyword);
}

class RemoteProductDataSource extends ImplRemoteProductDataSource {
  final Dio dio;

  RemoteProductDataSource({required this.dio});
  @override
  Future<List<Product>> getProducts({int sortOptions = SortOptions.latest}) {
    String api = 'product/list?sort=$sortOptions';
    return dio.get(api).then((response) {
      List<Product> products = [];
      for (var item in response.data) {
        products.add(Product.fromJson(item));
      }
      return products;
    });
  }

  @override
  Future<List<Product>> search(String keyword) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
