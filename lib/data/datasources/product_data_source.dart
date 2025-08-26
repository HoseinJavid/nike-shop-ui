import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:practice/data/model/product.dart';

abstract class IProductDataSource {
  Future<List<Product>> getProducts(int sortParam);
}

class ProductRemoteDataSourceImpl implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSourceImpl({required this.httpClient});
  @override
  Future<List<Product>> getProducts(int sortParam) async {
    var response = await httpClient.get('/product/list?sort=$sortParam');
    List<Product> productsTmp = [];
    for (var element in response.data) {
      productsTmp.add(Product.fromJson(element));
    }
    return productsTmp;
  }
}

class ProductLocalDataSourceImpl implements IProductDataSource {
  //relational or non-relational
  @override
  Future<List<Product>> getProducts(int sortParam) {
    // TODO: implement getProducts
    throw UnimplementedError();
  }
}
