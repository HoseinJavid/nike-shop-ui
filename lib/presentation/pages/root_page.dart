import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/data/model/cart_list.dart';
import 'package:practice/data/model/product.dart';
import 'package:practice/presentation/pages/cod_confrimation_page.dart';
import 'package:practice/presentation/pages/payment_info_page/pre_payment_info_page.dart';
import 'package:practice/presentation/pages/auth_page/auth_page.dart';
import 'package:practice/presentation/pages/cart_page/cart_page.dart';
import 'package:practice/presentation/pages/home_page/home_page.dart';
import 'package:practice/presentation/pages/paymentResult_page.dart';
import 'package:practice/presentation/pages/product_detail_page/product_detail_page.dart';
import 'package:practice/presentation/pages/product_list_page/product_list_page.dart';
import 'package:practice/presentation/pages/profile_page/profile_page.dart';
import 'package:practice/presentation/pages/search_page/search_page.dart';
import 'package:practice/presentation/pages/splash.dart';

final GoRouter routers = GoRouter(
  // initialLocation: '/splash',
  // initialLocation: '/search',
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
              builder: (context, state) => ProfilePage(),
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
                  builder: (context, state) =>
                      PrePaymentInfoPage(cartList: state.extra as CartList),
                ),

                // GoRoute(
                //   path: 'productDetail',
                //   builder: (context, state) {
                //     final product = state.extra as Product;
                //     return ProductDetailPage(product: product);
                //   },
                // ),
                GoRoute(
                  path: 'productList',
                  builder: (context, state) => ProductListPage(),
                ),
                GoRoute(
                  path: 'paymentResult',
                  builder: (context, state) {
                    return PaymentResultPage(
                      queryParameters: state.extra as Map<String, dynamic>,
                    );
                  },
                ),
                GoRoute(
                  path: 'codConfrimationResult',
                  builder: (context, state) {
                    var extra = state.extra as Map<String, dynamic>;
                    return CodConfrimResultPage(
                      price: extra['price'],
                      isSuccess: extra['isSuccess'],
                      orderId: extra['orderId'] as int,
                    );
                  },
                ),
                GoRoute(
                  path: '/search',
                  builder: (context, state) => const SearchPage(),
                ),
                GoRoute(
                  path: '/productDetail',
                  builder: (context, state) {
                    final product = state.extra as Product;
                    return ProductDetailPage(product: product);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
      // navigatorContainerBuilder: (BuildContext context, StatefulNavigationShell navigationShell, List<Widget> children) {
      //       return children[navigationShell.currentIndex];
      //  },
    ),

    GoRoute(path: '/auth', builder: (context, state) => const AuthPage()),
    GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
  ],
);

class RootPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const RootPage({super.key, required this.navigationShell});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    //deeplink ..............................
    _linkSubscription = AppLinks().uriLinkStream.listen((uri) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.go('/paymentResult', extra: uri.queryParameters);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('RootPage dispose');
    _linkSubscription!.cancel();
    super.dispose();
  }

  @override
  void deactivate() {
    debugPrint('RootPage deactivate');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.navigationShell.currentIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        backgroundColor: Colors.white,
        onTap: (index) {
          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          );

          // if (index == 0) {
          //   navigationShell.goBranch(index, initialLocation: true);
          // }
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

//-------------------------------------------------------------------------------
// GoRouter routers = GoRouter(
//   initialLocation: '/',
//   // initialLocation: '/auth',
//   routes: [
//     ShellRoute(
//       redirect: (context, state) {
//         return null;
//       },
//       builder: (context, state, child) {
//         return RootPage(child: child);
//       },
//       routes: [
//         GoRoute(path: '/', builder: (context, state) => const HomePage()),
//         GoRoute(
//           path: '/paymentInfo',
//           builder: (context, state) => const PaymentInfoPage(),
//         ),
//         GoRoute(
//           path: '/paymentResult',
//           builder: (context, state) => const PaymentResultPage(),
//         ),
//         GoRoute(
//           path: '/productDetail',
//           builder: (context, state) => const ProductDetailPage(),
//         ),
//         GoRoute(
//           path: '/productList',
//           builder: (context, state) {
//             return ProductListPage();
//           },
//         ),
//         GoRoute(
//           path: '/profile',
//           builder: (context, state) => const ProfilePage(),
//         ),
//         GoRoute(path: '/carPage', builder: (context, state) => CartPage()),
//       ],
//     ),
//     GoRoute(path: '/auth', builder: (context, state) => const AuthPage()),
//   ],
// );

// class RootPage extends StatefulWidget {
//   final Widget child;
//   const RootPage({super.key, required this.child});

//   @override
//   State<RootPage> createState() => _RootPageState();
// }

// class _RootPageState extends State<RootPage> {
//   int correntNavIndex = 2;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: widget.child,
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Theme.of(context).primaryColor,
//         showUnselectedLabels: true,
//         backgroundColor: Colors.white,
//         showSelectedLabels: true,
//         currentIndex: correntNavIndex,
//         onTap: (value) {
//           setState(() {
//             correntNavIndex = value;
//           });
//           switch (value) {
//             case 0:
//               // navigate...
//               context.go('/profile');
//               break;
//             case 1:
//               // navigate...
//               context.go('/carPage');
//               break;
//             case 2:
//               // navigate...
//               context.go('/');
//               break;
//             default:
//           }
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline_outlined, size: 28),
//             label: 'اطلاعات کاربری',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_bag_outlined, size: 28),
//             label: 'سبدخرید',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined, size: 28),
//             label: 'خانه',
//           ),
//         ],
//       ),
//     );
//   }
// }
