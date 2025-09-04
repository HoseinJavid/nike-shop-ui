/// AuthPage is a StatefulWidget that presents a user authentication interface.
///
/// This page displays a login form with the following features:
/// - RTL (Right-to-Left) text direction for Persian language support.
/// - Nike logo and welcome message.
/// - Input fields for email and password using [McwTextFild].
/// - Login button styled with rounded corners.
/// - Option to navigate to the registration page.
///
/// The page uses [LightTheme.secondryColor] as its background and adapts its layout
/// based on the device's screen size.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/core/theme/theme.dart';
import 'package:practice/gen/assets.gen.dart';
import 'package:practice/presentation/pages/auth_page/bloc/auth_bloc.dart';
import 'package:practice/presentation/widgets/widgets.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<AuthBloc>(context);
    var themeData = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) => true,
        listener: (context, state)async {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                key: UniqueKey(),
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('ورود با موفقیت انجام شد'),
                backgroundColor: Colors.blue,
                duration: Duration(milliseconds: 500),
              ),
            );
            await Future.delayed(Duration(milliseconds: 1000));
            context.go('/');
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: LightTheme.secondryColor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.img.nikeLogoWite.path,
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                    Text(
                      'خوش آمدید',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      state.authMode == AuthMode.login
                          ? 'اطلاعات حساب کاربری خود را وارد کنید'
                          : 'برای ثبت نام اطلاعات خود را وارد کنید',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 30),
                    McwTextFild(
                      hintText: 'نام کاربری',
                      controller: emailController,
                      key: ValueKey('email'),
                    ),
                    SizedBox(height: 15),
                    McwTextFild(
                      hintText: 'رمز عبور',
                      obsecureText: true,
                      controller: passwordController,
                      key: ValueKey('password'),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (state.authMode == AuthMode.login) {
                            bloc.add(
                              StartLoginUser(
                                username: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          } else {
                            bloc.add(
                              StartSignUpUser(
                                username: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: state is AuthLoading
                            ? CircularProgressIndicator(
                                color: themeData.primaryColor,
                              )
                            : Text(
                                state.authMode == AuthMode.login
                                    ? 'ورود'
                                    : 'ثبت نام',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        bloc.add(ChangeAuthMode());
                      },
                      child: Text(
                        state.authMode == AuthMode.login
                            ? 'حساب کاربری ندارید؟ ثبت نام کنید'
                            : 'حساب کاربری دارید؟ وارد شوید',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
