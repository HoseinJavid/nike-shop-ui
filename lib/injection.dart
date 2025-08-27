import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/core/network/httpClient_remote.dart';
import 'package:practice/data/datasources/banner_data_source.dart';
import 'package:practice/data/datasources/product_data_source.dart';
import 'package:practice/data/repository/banner_repository.dart';
import 'package:practice/data/repository/product_repository.dart';
import 'package:practice/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:practice/presentation/pages/product_list_page/bloc/product_list_bloc.dart';

//service locator
class MyBlocProvider extends StatelessWidget {
  final Widget child;
  const MyBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            ProductRepositoryImpl(
              remote: ProductRemoteDataSourceImpl(httpClient: httpClient),
              local: null,
            ),
            BannerRepositoryImpl(
              remote: BannerRemoteDataSourceImpl(httpClient: httpClient),
              local: null,
            ),
          ),
        ),
        BlocProvider(create: (context) => ProductListBloc()),
      ],
      child: child,
    );
  }
}
