import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:practice/data/model/banner.dart';
import 'package:practice/data/model/product.dart';
import 'package:practice/data/repository/banner_repository.dart';
import 'package:practice/data/repository/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IproductRepository productRepository;
  final IBannerRepository bannerRepository;
  HomeBloc(this.productRepository, this.bannerRepository)
    : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      try {
        emit(HomeLoading());
        if (event is HomeLoadStart) {
          var banners = await bannerRepository.getBanners();
          var newestProducts = await productRepository.getProducts(0);
          var popularProducts = await productRepository.getProducts(1);
          var expensiveProducts = await productRepository.getProducts(2);
          var cheapProducts = await productRepository.getProducts(3);
          emit(
            HomeLoaded(
              newestProducts: newestProducts,
              banners: banners,
              expensiveProducts: expensiveProducts,
              cheapProducts: cheapProducts,
              popularProducts: popularProducts,
            ),
          );
        }
      } catch (e) {
        if (e is DioError) {
          emit(HomeError('خطای شبکه'));
        } else {
          emit(HomeError('خطای ناشناخته'));
        }
      }
    });
  }
}
