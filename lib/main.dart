import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce/screen/home/home.dart';
import 'package:nike_ecommerce/screen/login/bloc/login_bloc.dart';
import 'package:nike_ecommerce/screen/login/login.dart';
import 'package:nike_ecommerce/screen/splash/splash.dart';
import 'package:nike_ecommerce/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
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
      home: const SplashScreen(),
    );
  }
}
