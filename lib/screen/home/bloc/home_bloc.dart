import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:meta/meta.dart';
import 'package:nike_ecommerce/data/model/banner.dart';
import 'package:nike_ecommerce/data/model/product.dart';
import 'package:nike_ecommerce/data/repo/banner_repository.dart';
import 'package:nike_ecommerce/data/repo/product_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannerRepository bannerRepository;
  final ProductRepository productRepository;
  late AppLocalizations _appLocalizations;
  HomeBloc(this.bannerRepository, this.productRepository)
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      try {
        if (event is HomeStartInit) {
          emit(HomeLoading());
          var products = await productRepository.getProducts();
          var banners = await bannerRepository.getBanners();
          emit(HomeSucces(products: products, banners: banners));
        } else if (event is ChangeSortOption) {
          emit(HomeLoading());
          var products = await productRepository.getProducts(
              sortOptions: event.sortOption);
          var banners = await bannerRepository.getBanners();
          emit(HomeSucces(products: products, banners: banners));
        }
      } catch (e) {
        if (e is DioException) {
          emit(HomeError(massage: _appLocalizations.netWorkError));
        } else {
          emit(HomeError(massage: _appLocalizations.unknownError));
        }
      }
    });
  }
  void setAppLocalizations(AppLocalizations value) {
    _appLocalizations = value;
  }
}
