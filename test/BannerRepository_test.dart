import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice/data/datasources/banner_data_source.dart';
import 'package:practice/data/model/banner.dart';
import 'package:practice/data/repository/banner_repository.dart';

void main() {
  late IBannerRepository bannerRepository;
  late BannerRemoteDataSourceImpl remote;
  // late BannerLocalDataSourceImpl local;
  late Dio httpClient;

  setUp(() {
    httpClient = Dio(BaseOptions(baseUrl: 'http://localhost:8085/api/v1'));
    remote = BannerRemoteDataSourceImpl(httpClient: httpClient);
    // local = BannerLocalDataSource();
    bannerRepository = BannerRepositoryImpl(remote: remote, local: null);
  });

  test('fetchProducts returns a list of products', () async {
    final banners = await bannerRepository.getBanners();
    expect(banners, isA<List<Banner>>());
    expect(banners.isNotEmpty, true);
  });
}
