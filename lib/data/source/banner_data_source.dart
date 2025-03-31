import 'package:dio/dio.dart';
import 'package:nike_ecommerce/common/app_constants.dart';
import 'package:nike_ecommerce/data/model/banner.dart';

abstract class ImplRemoteBannerDataSource {
  Future<List<Banner>> getBanners();
}

class RemoteBannerDataSource extends ImplRemoteBannerDataSource {
  final Dio dio;

  RemoteBannerDataSource({required this.dio});

  @override
  Future<List<Banner>> getBanners() {
    String api ='banner/slider';
    return dio.get(api).then((response) {
      List<Banner> banners = [];
      for (var item in response.data) {
        banners.add(Banner.fromJson(item));
      }
      return banners;
    });
  }
}
