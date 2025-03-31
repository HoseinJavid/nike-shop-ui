import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nike_ecommerce/common/app_constants.dart';
import 'package:nike_ecommerce/data/model/banner.dart';
import 'package:nike_ecommerce/data/model/product.dart';
import 'package:nike_ecommerce/data/repo/banner_repository.dart';
import 'package:nike_ecommerce/data/repo/product_repository.dart';
import 'package:nike_ecommerce/data/source/banner_data_source.dart';
import 'package:nike_ecommerce/data/source/product_data_source.dart';

void main() {
  group('ImplRemoteProductDataSource', () {
    late Dio dio;
    late ProductRepository implProductRepository;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrlTest));
      implProductRepository = ProductRepository(
          productDataSource: RemoteProductDataSource(dio: dio));
    });

    test('getProducts should return a list of products from a real API',
        () async {
      final result =
          await implProductRepository.getProducts();

      expect(result, isA<List<Product>>());
      expect(result.isNotEmpty, true);
    });
  });

  group('ImplBannerDataSource', () {
    late Dio dio;
    late BannerRepository bannerRepository;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrlTest));
      bannerRepository = BannerRepository(
          remoteBannerDataSource: RemoteBannerDataSource(dio: dio));
    });

    test('getBanners should return a list of banner from a real API', () async {
      final result = await bannerRepository.getBanners();

      expect(result, isA<List<Banner>>());
      expect(result.isNotEmpty, true);
    });
  });
}
