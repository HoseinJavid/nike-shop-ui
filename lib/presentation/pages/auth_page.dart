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
import 'package:practice/core/theme/theme.dart';
import 'package:practice/gen/assets.gen.dart';
import 'package:practice/presentation/widgets/widgets.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                'اطلاعات حساب کاربری خود را وارد کنید',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 30),
              McwTextFild(hintText: 'پست الکترونیکی'),
              SizedBox(height: 15),
              McwTextFild(hintText: 'رمز عبور', obsecureText: true),
              SizedBox(height: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'ورود',
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
                onPressed: () {},
                child: Text(
                  'حساب کاربری ندارید؟ ثبت نام کنید',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

