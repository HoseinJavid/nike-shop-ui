import 'package:nike_ecommerce/common/app_constants.dart';

import '../model/product.dart';
import '../source/product_data_source.dart';

abstract class ImplProductRepository {
  Future<List<Product>> getProducts({int sortOptions});
  Future<List<Product>> search(String keyword);
}

class ProductRepository extends ImplProductRepository {
  final ImplRemoteProductDataSource productDataSource;

  ProductRepository({required this.productDataSource});

  @override
  Future<List<Product>> getProducts({int sortOptions = SortOptions.latest}) {
    return productDataSource.getProducts(sortOptions: sortOptions);
  }

  @override
  Future<List<Product>> search(String keyword) {
    return productDataSource.search(keyword);
  }
}
