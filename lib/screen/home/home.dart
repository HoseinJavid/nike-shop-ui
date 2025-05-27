import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:intl/intl.dart';
import 'package:nike_ecommerce/common/app_constants.dart';
import 'package:nike_ecommerce/l10n/app_localizations.dart';
import 'package:nike_ecommerce/screen/home/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(HomeStartInit());
    context.read<HomeBloc>().setAppLocalizations(AppLocalizations.of(context)!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    Locale locale = Localizations.localeOf(context);
    NumberFormat numberFormat =
        NumberFormat.decimalPattern(locale.languageCode);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Search(themeData: themeData),
          ),
          const SliverToBoxAdapter(
            child: Banner(),
          ),
          SliverToBoxAdapter(
            child: CategoryTitleProduct(
              appLocalizations: appLocalizations,
              themeData: themeData,
              titleCategory: appLocalizations.theLatestText,
            ),
          ),
          SliverToBoxAdapter(
            child: ListProducts(
              themeData: themeData,
              numberFormat: numberFormat,
              appLocalizations: appLocalizations,
              changeSortOptionEvent: ChangeSortOption(SortOptions.latest),
            ),
          ),
          SliverToBoxAdapter(
            child: CategoryTitleProduct(
              appLocalizations: appLocalizations,
              themeData: themeData,
              titleCategory: appLocalizations.thePopular,
            ),
          ),
          SliverToBoxAdapter(
            child: ListProducts(
              themeData: themeData,
              numberFormat: numberFormat,
              appLocalizations: appLocalizations,
              changeSortOptionEvent: ChangeSortOption(SortOptions.popular),
            ),
          ),
          SliverToBoxAdapter(
            child: CategoryTitleProduct(
              appLocalizations: appLocalizations,
              themeData: themeData,
              titleCategory: appLocalizations.theMostExpensiveText,
            ),
          ),
          SliverToBoxAdapter(
            child: ListProducts(
              themeData: themeData,
              numberFormat: numberFormat,
              appLocalizations: appLocalizations,
              changeSortOptionEvent: ChangeSortOption(SortOptions.priceHighToLow),
            ),
          ),
          SliverToBoxAdapter(
            child: CategoryTitleProduct(
              appLocalizations: appLocalizations,
              themeData: themeData,
              titleCategory: appLocalizations.theCheapestText,
            ),
          ),
          SliverToBoxAdapter(
            child: ListProducts(
              themeData: themeData,
              numberFormat: numberFormat,
              appLocalizations: appLocalizations,
              changeSortOptionEvent: ChangeSortOption(SortOptions.priceLowToHigh),
            ),
          ),
        ],
      ),
    );
  }
}

class ListProducts extends StatefulWidget {
  const ListProducts({
    super.key,
    required this.themeData,
    required this.numberFormat,
    required this.appLocalizations,
    required this.changeSortOptionEvent,
  });

  final ThemeData themeData;
  final NumberFormat numberFormat;
  final AppLocalizations appLocalizations;
  final ChangeSortOption changeSortOptionEvent;

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  @override
  void initState() {
    context.read<HomeBloc>().add(widget.changeSortOptionEvent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 408,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSucces) {
            // if (widget.changeSortOption.sortOption == state.sortOptions) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.products!.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 300,
                    width: 240,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: state.products![index].imageUrl,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                      child: Icon(Icons.error_outline)),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(state.products![index].title,
                              style: widget.themeData.textTheme.titleLarge),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                              '${widget.numberFormat.format(state.products![index].previousPrice.toInt())} ${widget.appLocalizations.theCurrency}',
                              style: widget.themeData.textTheme.titleSmall!
                                  .apply(
                                      decorationColor:
                                          Colors.black.withOpacity(0.5),
                                      color: Colors.black.withOpacity(0.5),
                                      fontSizeFactor: 0.85,
                                      decoration: TextDecoration.lineThrough)),
                          Text(
                            '${widget.numberFormat.format(state.products![index].price.toInt())} ${widget.appLocalizations.theCurrency}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            // }
          } else if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeError) {
            return Center(
              child: ErrorWidget(
                homeError: state,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class CategoryTitleProduct extends StatelessWidget {
  const CategoryTitleProduct({
    super.key,
    required this.appLocalizations,
    required this.themeData,
    required this.titleCategory,
  });

  final AppLocalizations appLocalizations;
  final ThemeData themeData;
  final String titleCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              child: Text(
            titleCategory,
            style: themeData.textTheme.bodyLarge!
                .copyWith(color: Colors.black.withOpacity(0.4)),
          )),
          GestureDetector(
              child: Text(
            appLocalizations.showAllItem,
            style: themeData.textTheme.bodyLarge!
                .copyWith(color: themeData.colorScheme.primary),
          )),
        ],
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 270,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSucces) {
                return PageView.builder(
                  itemCount: state.banners.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: state.banners[index].imageUrl,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error_outline)),
                    );
                  },
                );
              } else if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeError) {
                return Center(
                  child: ErrorWidget(
                    homeError: state,
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final HomeError homeError;
  const ErrorWidget({
    super.key,
    required this.homeError,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline),
        const SizedBox(
          height: 4,
        ),
        Text(homeError.massage)
      ],
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        Image.asset(
          'assets/img/nike_logo_dark.png',
          width: 80,
          height: 80,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4, left: 4, bottom: 16),
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: themeData.colorScheme.primary),
                borderRadius: BorderRadius.circular(4),
              ),
              labelText: AppLocalizations.of(context)!.searchText,
              labelStyle: TextStyle(
                color: themeData.colorScheme.primary.withOpacity(0.8),
              ),
              prefixIcon: const Icon(CupertinoIcons.search),
            ),
          ),
        ),
      ],
    );
  }
}
