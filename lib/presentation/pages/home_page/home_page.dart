import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/core/constants/constant.dart';
import 'package:practice/core/error/m_exeption.dart';
import 'package:practice/gen/assets.gen.dart';
import 'package:practice/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:practice/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

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
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ShimmerLogo(),
                      const SizedBox(height: 10),
                      ShimmerSearchBar(),
                      const SizedBox(height: 10),
                      ShimmerBannerList(),
                      // TitleProductWidget(
                      //   title: 'پرفروش ترین محصولات',
                      //   sortType: SortType.bestSelling,
                      // ),
                      ShimmerCategoryButtoms(),
                      ShimmerProductList(),
                      // TitleProductWidget(
                      //   title: 'جدیدترین محصولات',
                      //   sortType: SortType.newest,
                      // ),
                      ShimmerCategoryButtoms(),
                      ShimmerProductList(),
                    ],
                  ),
                ),
              );
            } else if (state is HomeError) {
              return Center(
                child: McwShowError(
                  state: state,
                  heightContainer: 250,
                  widthContainer: MediaQuery.of(context).size.width,
                  onTryAgain: () =>
                      context.read<HomeBloc>().add(HomeLoadStart()),
                ),
              );
            } else if (state is HomeLoaded) {
              return SafeArea(
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
                      const SizedBox(height: 10),
                      BannerList(banners: state.banners),
                      TitleProductWidget(
                        title: 'محبوب ترین محصولات',
                        sortType: SortType.popular,
                      ),
                      ProductList(products: state.popularProducts),
                      TitleProductWidget(
                        title: 'جدیدترین محصولات',
                        sortType: SortType.newest,
                      ),
                      ProductList(products: state.newestProducts),
                    ],
                  ),
                ),
              );
            }
            // Initial or unknown state
            return Container();
          },
        ),
      ),
    );
  }
}

class McwShowError extends StatelessWidget {
  final AppError state;
  final double heightContainer;
  final double widthContainer;
  final VoidCallback onTryAgain;

  const McwShowError({
    super.key,
    required this.state,
    required this.heightContainer,
    required this.widthContainer,
    required this.onTryAgain,
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
                onTryAgain();
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

// Shimmer placeholders

class ShimmerLogo extends StatelessWidget {
  const ShimmerLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
      ],
    );
  }
}

class ShimmerSearchBar extends StatelessWidget {
  const ShimmerSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class ShimmerBannerList extends StatelessWidget {
  const ShimmerBannerList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 200,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerProductList extends StatelessWidget {
  const ShimmerProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 324,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 200,
            height: 324,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerCategoryButtoms extends StatelessWidget {
  const ShimmerCategoryButtoms({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.only(top: 13, bottom: 13, right: 8, left: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 161,
              height: 23,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              width: 89,
              height: 23,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
