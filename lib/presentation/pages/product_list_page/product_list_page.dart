import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/core/constants/constant.dart';
import 'package:practice/data/model/product.dart';
import 'package:practice/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:practice/presentation/pages/product_list_page/bloc/product_list_bloc.dart';
import 'package:practice/presentation/widgets/widgets.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  LayoutType layoutType = LayoutType.grid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: McwAppBarProductList(
          onChangedLayoutType: (LayoutType value) {
            // Handle layout type change
            // You can update the state or perform any action based on the layout type
            setState(() {
              // Update the layout type or perform any necessary action
              layoutType = value;
            });
          },
        ),
        body: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            var homeState = context.read<HomeBloc>().state;
            if (state is ProductListInitial ||
                state is ProductListSortTypeChanged) {
              if (state.sortType == SortType.cheapest) {
                if (homeState is HomeLoaded) {
                  List<Product> products = homeState.cheapProducts;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: GridView.builder(
                      key: ValueKey("${layoutType}_${state.sortType}"),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: layoutType == LayoutType.grid ? 2 : 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: layoutType == LayoutType.grid
                            ? 0.0
                            : 8.0,
                        childAspectRatio: layoutType == LayoutType.grid
                            ? 0.65
                            : 0.8,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductWidget(
                          layoutType: layoutType,
                          products: product,
                        );
                      },
                    ),
                  );
                }
              } else if (state.sortType == SortType.popular) {
                if (homeState is HomeLoaded) {
                  List<Product> products = homeState.popularProducts;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: GridView.builder(
                      key: ValueKey("${layoutType}_${state.sortType}"),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: layoutType == LayoutType.grid ? 2 : 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: layoutType == LayoutType.grid
                            ? 0.0
                            : 8.0,
                        childAspectRatio: layoutType == LayoutType.grid
                            ? 0.65
                            : 0.8,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductWidget(
                          layoutType: layoutType,
                          products: product,
                        );
                      },
                    ),
                  );
                }
              } else if (state.sortType == SortType.newest) {
                if (homeState is HomeLoaded) {
                  List<Product> products = homeState.newestProducts;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: GridView.builder(
                      key: ValueKey("${layoutType}_${state.sortType}"),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: layoutType == LayoutType.grid ? 2 : 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: layoutType == LayoutType.grid
                            ? 0.0
                            : 8.0,
                        childAspectRatio: layoutType == LayoutType.grid
                            ? 0.65
                            : 0.8,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductWidget(
                          layoutType: layoutType,
                          products: product,
                        );
                      },
                    ),
                  );
                }
              } else if (state.sortType == SortType.mostExpensive) {
                if (homeState is HomeLoaded) {
                  List<Product> products = homeState.expensiveProducts;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: GridView.builder(
                      key: ValueKey("${layoutType}_${state.sortType}"),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: layoutType == LayoutType.grid ? 2 : 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: layoutType == LayoutType.grid
                            ? 0.0
                            : 8.0,
                        childAspectRatio: layoutType == LayoutType.grid
                            ? 0.65
                            : 0.8,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductWidget(
                          layoutType: layoutType,
                          products: product,
                        );
                      },
                    ),
                  );
                }
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
