import 'package:flutter/material.dart';
import 'package:practice/core/theme/theme.dart';
import 'package:practice/presentation/pages/auth_page.dart';
import 'package:practice/presentation/pages/home_page.dart';

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
        child: const HomePage(),
      ),
    );
  }
}
