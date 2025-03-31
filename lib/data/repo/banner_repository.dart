import 'package:nike_ecommerce/data/model/banner.dart';
import 'package:nike_ecommerce/data/source/banner_data_source.dart';

abstract class ImplBannerRepository {
  Future<List<Banner>> getBanners();
}

class BannerRepository extends ImplBannerRepository {
  final RemoteBannerDataSource remoteBannerDataSource;

  BannerRepository({required this.remoteBannerDataSource});

  @override
  Future<List<Banner>> getBanners() {
    return remoteBannerDataSource.getBanners();
  }
}
