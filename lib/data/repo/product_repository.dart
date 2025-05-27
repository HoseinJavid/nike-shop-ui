import 'package:nike_ecommerce/common/app_constants.dart';
import 'package:nike_ecommerce/screen/home/bloc/home_bloc.dart';

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

  Stream<Product> getProductsStream({required ChangeSortOption changeSortOption}) async* {
    final productList = await getProducts(sortOptions: changeSortOption.sortOption);
    for (final product in productList) {
      await Future.delayed(Duration(milliseconds: 300)); // انیمیشن تدریجی
      yield product;
    }
  }
}
