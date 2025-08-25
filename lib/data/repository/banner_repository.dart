import 'package:practice/data/datasources/banner_data_source.dart';
import 'package:practice/data/model/banner.dart';

abstract class IBannerRepository extends IBannerDataSource {}

class BannerRepositoryImpl implements IBannerRepository {
  final BannerRemoteDataSourceImpl remote;
  final BannerLocalDataSourceImpl? local;

  BannerRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<Banner>> getBanners() {
    return remote.getBanners();
  }
}
