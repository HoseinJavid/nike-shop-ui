import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practice/gen/assets.gen.dart';
import 'package:practice/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:practice/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeBloc>().add(HomeLoadStart());

    super.initState();
  }

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
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return BannerList(banners: state.banners);
                    } else if (state is HomeLoading) {
                      return SizedBox(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return Container();
                  },
                ),

                TitleProductWidget(title: 'محبوب ترین محصولات'),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return ProductList(products: state.popularProducts);
                    } else if (state is HomeLoading) {
                      return SizedBox(
                        height: 340,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return Container();
                  },
                ),
                TitleProductWidget(title: 'جدیدترین محصولات'),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return ProductList(products: state.newestProducts);
                    } else if (state is HomeLoading) {
                      return SizedBox(
                        height: 340,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
