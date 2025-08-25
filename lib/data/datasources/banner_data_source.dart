import 'package:dio/dio.dart';
import 'package:practice/data/model/banner.dart';

abstract class IBannerDataSource {
  Future<List<Banner>> getBanners();
}

class BannerRemoteDataSourceImpl implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<List<Banner>> getBanners() async {
    var response = await httpClient.get('/banner/slider');
    List<Banner> bannersTmp = [];
    for (var element in response.data) {
      bannersTmp.add(Banner.fromJson(element));
    }
    return bannersTmp;
  }
}

class BannerLocalDataSourceImpl implements IBannerDataSource {
  @override
  Future<List<Banner>> getBanners() {
    // TODO: implement getBanners
    throw UnimplementedError();
  }
}
