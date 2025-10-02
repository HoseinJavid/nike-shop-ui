import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:practice/core/local/sharedPreferences_local.dart';
import 'package:practice/core/network/httpClient_remote.dart';
import 'package:practice/data/datasources/auth_data_source.dart';
import 'package:practice/data/datasources/banner_data_source.dart';
import 'package:practice/data/datasources/cart_data_source.dart';
import 'package:practice/data/datasources/comment_data_source.dart';
import 'package:practice/data/datasources/product_data_source.dart';
import 'package:practice/data/repository/auth_repository.dart';
import 'package:practice/data/repository/banner_repository.dart';
import 'package:practice/data/repository/cart_repository.dart';
import 'package:practice/data/repository/comment_repository.dart';
import 'package:practice/data/repository/product_repository.dart';
import 'package:practice/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerSingleton<SharedPreferences>(await initSharedPreferences());
  getIt.registerSingleton<Dio>(initDio());
  getIt.registerLazySingleton(
    () => ProductRepositoryImpl(
      remote: ProductRemoteDataSourceImpl(httpClient: getIt<Dio>()),
      local: null,
    ),
  );
  getIt.registerLazySingleton(
    () => BannerRepositoryImpl(
      remote: BannerRemoteDataSourceImpl(httpClient: getIt<Dio>()),
      local: null,
    ),
  );
  getIt.registerLazySingleton(
    () => AuthRepositoryImpl(
      remote: AuthRemoteDataSourceImpl(httpClient: getIt<Dio>()),
      local: AuthLocalDataSourceImpl(
        sharedPreferences: getIt<SharedPreferences>(),
      ),
    ),
  );
  getIt.registerLazySingleton(
    () => CartRepositoryImpl(
      remote: CartRemoteDataSourceImpl(httpClient: getIt<Dio>()),
      local: null,
    ),
  );

  getIt.registerLazySingleton(
    () => CommentRepositoryImpl(
      remote: CommentRemoteDataSourceImpl(httpClient: getIt<Dio>()),
    ),
  );

  getIt.registerLazySingleton(
    () => CartBloc(getIt<AuthRepositoryImpl>(), getIt<CartRepositoryImpl>()),
  );
}
