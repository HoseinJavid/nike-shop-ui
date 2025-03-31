import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce/common/app_constants.dart';
import 'package:nike_ecommerce/common/dio_client.dart';
import 'package:nike_ecommerce/data/repo/banner_repository.dart';
import 'package:nike_ecommerce/data/repo/product_repository.dart';
import 'package:nike_ecommerce/data/source/banner_data_source.dart';
import 'package:nike_ecommerce/data/source/product_data_source.dart';
import 'package:nike_ecommerce/screen/home/bloc/home_bloc.dart';
import 'package:nike_ecommerce/screen/home/home.dart';
import 'package:nike_ecommerce/screen/login/bloc/login_bloc.dart';
import 'package:nike_ecommerce/screen/login/login.dart';
import 'package:nike_ecommerce/screen/splash/splash.dart';
import 'package:nike_ecommerce/common/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var dio = DioClient.dio;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
    create: (context) {
      return HomeBloc(
        BannerRepository(
            remoteBannerDataSource: RemoteBannerDataSource(dio: dio)),
        ProductRepository(productDataSource: RemoteProductDataSource(dio: dio)),
      );
    },
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Locale localeSystem = const Locale('fa', 'IR');
    // Locale localeSystem = const Locale('en', 'US');

    return MaterialApp(
      title: 'nike shop',
      locale: localeSystem,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: MyTheme.getTheme(locale: localeSystem),
      home: const HomeScreen(),
    );
  }
}
