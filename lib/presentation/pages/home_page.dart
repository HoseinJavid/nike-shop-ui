import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practice/gen/assets.gen.dart';
import 'package:practice/presentation/widgets/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.img.nikeLogoDark.path,
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'جستجوی محصولات',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                BannerList(),
                TitleProductWidget(title: 'محصولات جدید'),
                ProductList(),
                TitleProductWidget(title: 'محصولات پرفروش'),
                ProductList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
