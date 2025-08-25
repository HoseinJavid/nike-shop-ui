import 'package:practice/data/datasources/product_data_source.dart';
import 'package:practice/data/model/product.dart';

abstract class IproductRepository extends IProductDataSource {}

class ProductRepositoryImpl implements IproductRepository {
  final IProductDataSource remote;
  final IProductDataSource? local;

  ProductRepositoryImpl({required this.remote, required this.local});
  @override
  Future<List<Product>> getProducts(int sortParam) {
    return remote.getProducts(sortParam);
  }
}
