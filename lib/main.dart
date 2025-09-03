import 'package:flutter/material.dart';
import 'package:practice/core/local/sharedPreferences_local.dart';
import 'package:practice/core/network/httpClient_remote.dart';
import 'package:practice/core/theme/theme.dart';
import 'package:practice/injection.dart';
import 'package:practice/presentation/pages/PaymentInfo_page.dart';
import 'package:practice/presentation/pages/auth_page/auth_page.dart';
import 'package:practice/presentation/pages/cart_page.dart';
import 'package:practice/presentation/pages/home_page/home_page.dart';
import 'package:practice/presentation/pages/paymentResult_page.dart';
import 'package:practice/presentation/pages/product_detail_page.dart';
import 'package:practice/presentation/pages/product_list_page/product_list_page.dart';
import 'package:practice/presentation/pages/profile_page.dart';
import 'package:practice/presentation/pages/root_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSharedPreferences();
  initDio();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyBlocProvider(
      child: MaterialApp.router(
        theme: LightTheme().getLightTheme(const Locale('fa')),
        debugShowCheckedModeBanner: false,
        routerConfig: routers,
        // home: Directionality(
        // textDirection: TextDirection.rtl,
        // child: const ProductListPage(),
        // child: HomePage(),
        // child: ProductDetailPage(),
        // child: CartPage(),
        // child: ProfilePage(),
        // child: PaymentResultPage(),
        // child: PaymentInfoPage(),
        // child: AuthPage(),
        // ),
      ),
    );
  }
}
