import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/core/local/sharedPreferences_local.dart';
import 'package:practice/core/network/httpClient_remote.dart';
import 'package:practice/data/datasources/auth_data_source.dart';
import 'package:practice/data/datasources/banner_data_source.dart';
import 'package:practice/data/datasources/cart_data_source.dart';
import 'package:practice/data/datasources/product_data_source.dart';
import 'package:practice/data/repository/auth_repository.dart';
import 'package:practice/data/repository/banner_repository.dart';
import 'package:practice/data/repository/cart_repository.dart';
import 'package:practice/data/repository/comment_repository.dart';
import 'package:practice/data/repository/product_repository.dart';
import 'package:practice/di/service_locator.dart';
import 'package:practice/presentation/pages/auth_page/bloc/auth_bloc.dart';
import 'package:practice/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:practice/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:practice/presentation/pages/product_detail_page/bloc/product_detail_bloc.dart';
import 'package:practice/presentation/pages/product_list_page/bloc/product_list_bloc.dart';
import 'package:practice/presentation/pages/profile_page/bloc/profile_bloc.dart';

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
            getIt<ProductRepositoryImpl>(),
            getIt<BannerRepositoryImpl>(),
          ),
        ),
        BlocProvider(create: (context) => ProductListBloc()),
        BlocProvider(
          create: (context) => AuthBloc(getIt<AuthRepositoryImpl>()),
        ),
        BlocProvider(
          create: (context) => getIt<CartBloc>(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(getIt<AuthRepositoryImpl>()),
        ),

        BlocProvider(
          create: (context) =>
              ProductDetailBloc(getIt<CommentRepositoryImpl>()),
        ),
      ],
      child: child,
    );
  }
}


// //service locator
// class MyBlocProvider extends StatelessWidget {
//   final Widget child;
//   const MyBlocProvider({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => HomeBloc(
//             ProductRepositoryImpl(
//               remote: ProductRemoteDataSourceImpl(httpClient: _httpClient),
//               local: null,
//             ),
//             BannerRepositoryImpl(
//               remote: BannerRemoteDataSourceImpl(httpClient: _httpClient),
//               local: null,
//             ),
//           ),
//         ),
//         BlocProvider(create: (context) => ProductListBloc()),
//         BlocProvider(
//           create: (context) => AuthBloc(
//             AuthRepositoryImpl(
//               remote: AuthRemoteDataSourceImpl(httpClient: _httpClient),
//               local: AuthLocalDataSourceImpl(sharedPreferences: _shprefs),
//             ),
//           ),
//         ),
//         BlocProvider(
//           create: (context) => CartBloc(
//             AuthRepositoryImpl(
//               remote: AuthRemoteDataSourceImpl(httpClient: _httpClient),
//               local: AuthLocalDataSourceImpl(sharedPreferences: _shprefs),
//             ),
//             CartRepositoryImpl(
//               remote: CartRemoteDataSourceImpl(httpClient: _httpClient),
//               local: null,
//             ),
//           ),
//         ),
//         BlocProvider(
//           create: (context) => ProfileBloc(
//             AuthRepositoryImpl(
//               remote: AuthRemoteDataSourceImpl(httpClient: _httpClient),
//               local: AuthLocalDataSourceImpl(sharedPreferences: _shprefs),
//             ),
//           ),
//         ),
//       ],
//       child: child,
//     );
//   }
// }

