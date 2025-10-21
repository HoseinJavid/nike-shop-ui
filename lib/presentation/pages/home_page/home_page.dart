import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                      ShimmerCategoryButtoms(),
                      ShimmerProductList(),
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
                        child: McwSearchFild(
                          autoFocus: false,
                          onTap: () {
                            context.push('/search');
                          }, onChanged: (String value) {  },
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

class McwSearchFild extends StatelessWidget {
  final VoidCallback onTap;
  final ValueChanged<String> onChanged;
  final bool autoFocus;
  const McwSearchFild({
    super.key,
    required this.onTap,
    this.autoFocus = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      onChanged: (value) => onChanged(value),
      onTap: () => onTap(),
      decoration: InputDecoration(
        hintText: 'جستجوی محصولات',
        prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
