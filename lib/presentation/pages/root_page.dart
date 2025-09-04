import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/core/constants/constant.dart';
import 'package:practice/presentation/pages/PaymentInfo_page.dart';
import 'package:practice/presentation/pages/auth_page/auth_page.dart';
import 'package:practice/presentation/pages/cart_page/cart_page.dart';
import 'package:practice/presentation/pages/home_page/home_page.dart';
import 'package:practice/presentation/pages/paymentResult_page.dart';
import 'package:practice/presentation/pages/product_detail_page.dart';
import 'package:practice/presentation/pages/product_list_page/product_list_page.dart';
import 'package:practice/presentation/pages/profile_page/profile_page.dart';

final GoRouter routers = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return RootPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/carPage', builder: (context, state) => CartPage()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: 'paymentInfo',
                  builder: (context, state) => const PaymentInfoPage(),
                ),
                GoRoute(
                  path: 'paymentResult',
                  builder: (context, state) => const PaymentResultPage(),
                ),
                GoRoute(
                  path: 'productDetail',
                  builder: (context, state) => const ProductDetailPage(),
                ),
                GoRoute(
                  path: 'productList',
                  builder: (context, state) => ProductListPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    GoRoute(path: '/auth', builder: (context, state) => const AuthPage()),
  ],
);

class RootPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const RootPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        backgroundColor: Colors.white,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined, size: 28),
            label: 'اطلاعات کاربری',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined, size: 28),
            label: 'سبد خرید',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 28),
            label: 'خانه',
          ),
        ],
      ),
    );
  }
}
