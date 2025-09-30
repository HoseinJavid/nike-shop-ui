import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/gen/assets.gen.dart';
import 'package:practice/presentation/pages/auth_page/bloc/auth_bloc.dart';
import 'package:practice/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:practice/presentation/pages/profile_page/bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(LoadProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return Scaffold(
              backgroundColor: Color(0xfff4f4f4),
              appBar: AppBar(
                actionsPadding: EdgeInsets.all(8),
                backgroundColor: Colors.white,
                title: const Text(
                  'پروفایل',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.logout_outlined),
                  ),
                ],
              ),
              body: SizedBox.expand(
                child: Column(
                  children: [
                    SizedBox(height: 4),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(height: 32),
                            Image.asset(
                              Assets.img.nikeLogoDark.path,
                              width: 64,
                              height: 64,
                            ),
                            SizedBox(height: 24),
                            Text(
                              'HoseinJavid.dev@gmail.com',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 16),
                            Divider(color: Colors.grey.shade200, height: 1),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => print('tap'),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Icon(CupertinoIcons.heart),
                                      SizedBox(width: 4),
                                      Text(
                                        'لیست علاقه مندی ها',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(color: Colors.grey.shade200, height: 1),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => print('ontap'),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.shopping_bag_outlined),
                                      SizedBox(width: 4),
                                      Text(
                                        'سوابق سفارش',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(color: Colors.grey.shade200, height: 1),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  if (state.authMode == AuthMode.login) {
                                    showLogoutDialog(context);
                                  } else {
                                    // context.read<CartBloc>().add(
                                    //   LoadCart(),
                                    // );
                                    context.push('/auth');
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        state.authMode == AuthMode.login
                                            ? Icons.logout
                                            : Icons.login,
                                        color: state.authMode == AuthMode.login
                                            ? Colors.red
                                            : null,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        state.authMode == AuthMode.login
                                            ? 'خروج ازحساب کاربری'
                                            : 'ورودبه حساب کاربری',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color:
                                              state.authMode == AuthMode.login
                                              ? Colors.red
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

Future<void> showLogoutDialog(BuildContext context) async {
  final bool? shouldLogout = await showDialog<bool>(
    context: context,
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("خروج از حساب",style: TextStyle(fontWeight: FontWeight.bold),),
          content: const Text(
            "آیا مطمئن هستید می‌خواهید از حساب کاربری خود خارج شوید؟",style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("خروج",style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("لغو",style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      );
    },
  );

  if (shouldLogout == true) {
    context.read<ProfileBloc>().add(LogoutRequested());
    context.read<CartBloc>().add(LoadCart());
    context.read<ProfileBloc>().add(LoadProfile());
  }
}
