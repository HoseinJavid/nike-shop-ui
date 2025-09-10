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
    StatefulShellRoute(
      builder: (context, state, navigationShell) {
        return RootPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) =>  ProfilePage(key: UniqueKey(),),
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
      ], navigatorContainerBuilder: (BuildContext context, StatefulNavigationShell navigationShell, List<Widget> children) { 
            return children[navigationShell.currentIndex];
       },
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

          if (index == 0) {
            navigationShell.goBranch(index, initialLocation: true);
          }
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
