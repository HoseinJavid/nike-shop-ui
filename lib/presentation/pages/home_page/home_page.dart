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
                        child: Center(child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        )),
                      );
                    } else if (state is HomeError) {
                      return McwShowError(
                        state: state,
                        heightContainer: 250,
                        widthContainer: MediaQuery.of(context).size.width,
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
                        child: Center(child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        )),
                      );
                    } else if (state is HomeError) {
                      return McwShowError(
                        state: state,
                        heightContainer: 340,
                        widthContainer: MediaQuery.of(context).size.width,
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
                        child: Center(child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        )),
                      );
                    } else if (state is HomeError) {
                      return McwShowError(
                        state: state,
                        heightContainer: 340,
                        widthContainer: MediaQuery.of(context).size.width,
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

class McwShowError extends StatelessWidget {
  final HomeError state;
  final double heightContainer;
  final double widthContainer;

  const McwShowError({
    super.key,
    required this.state,
    required this.heightContainer,
    required this.widthContainer,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightContainer,
      width: widthContainer,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.wifi_exclamationmark,
              size: 50,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Text(
              state.message,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(HomeLoadStart());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('تلاش مجدد'),
            ),
          ],
        ),
      ),
    );
  }
}
