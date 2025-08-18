import 'package:flutter/material.dart';
import 'package:practice/core/theme/theme.dart';
import 'package:practice/presentation/pages/PaymentInfo_page.dart';
import 'package:practice/presentation/pages/auth_page.dart';
import 'package:practice/presentation/pages/cart_page.dart';
import 'package:practice/presentation/pages/paymentResult_page.dart';
import 'package:practice/presentation/pages/profile_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LightTheme().getLightTheme(const Locale('fa')),
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        // child: const ProductListPage(),
        // child: HomePage(),
        // child: ProductDetailPage(),
        // child: CartPage(),
        // child: ProfilePage(),
        child: PaymentResultPage(),
        // child: PaymentInfoPage(),
        // child: AuthPage(),
      ),
    );
  }
}
