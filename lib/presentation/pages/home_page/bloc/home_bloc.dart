import 'package:bloc/bloc.dart';
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
      emit(HomeLoading());
      if (event is HomeLoadProducts) {
        var products = await productRepository.getProducts(event.sort);
        var banners = await bannerRepository.getBanners();
        emit(HomeLoaded(products: products, banners: banners));
      }
    });
  }
}
