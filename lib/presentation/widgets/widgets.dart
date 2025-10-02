import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/core/constants/constant.dart';
import 'package:practice/core/error/m_exeption.dart';
import 'package:practice/core/utils/util.dart';
import 'package:practice/data/model/comment.dart';
import 'package:practice/data/model/product.dart';
import 'package:practice/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:practice/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:practice/presentation/pages/product_list_page/bloc/product_list_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:practice/data/model/banner.dart' as my_banner;

/// --------------------------------------------------------------------------
class McwTextFild extends StatelessWidget {
  /// Custom Text Field for email input
  final String hintText;
  final bool obsecureText;
  final TextEditingController controller;
  const McwTextFild({
    super.key,
    required this.hintText,
    this.obsecureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white54, width: 1.5),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white54),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        style: TextStyle(color: Colors.white),
        obscureText: obsecureText,
        obscuringCharacter: '★',
      ),
    );
  }
}

/// --------------------------------------------------------------------------
class BannerList extends StatelessWidget {
  final List<my_banner.Banner> banners;
  const BannerList({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Stack(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: pageController,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              return BannerWidget(imageUrl: banners[index].image);
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: MediaQuery.of(context).size.width / 2 - 30,
          right: MediaQuery.of(context).size.width / 2 - 30,
          child: SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: const ExpandingDotsEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: Colors.white,
              dotColor: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

/// --------------------------------------------------------------------------
class ProductList extends StatelessWidget {
  final List<Product> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: products.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return ProductWidget(
            product: products[index],
            layoutType: LayoutType.horizontalList,
          );
        },
      ),
    );
  }
}

/// --------------------------------------------------------------------------
class TitleProductWidget extends StatelessWidget {
  final String title;
  final SortType sortType;
  const TitleProductWidget({
    super.key,
    required this.title,
    required this.sortType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              context.push('/productList');
              context.read<ProductListBloc>().add(
                ChangeProductListSortTypeEvent(sortType: sortType),
              );
            },
            child: Text(
              'مشاهده همه',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// --------------------------------------------------------------------------
class ProductWidget extends StatefulWidget {
  final Product product;
  final LayoutType layoutType;
  const ProductWidget({
    super.key,
    required this.product,
    required this.layoutType,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool like = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.layoutType == LayoutType.verticallList
          ? const EdgeInsets.all(0)
          : const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          // Navigate to product details page
          context.push('/productDetail', extra: widget.product);
        },
        borderRadius: BorderRadius.circular(10),
        splashColor: Theme.of(context).primaryColor.withAlpha(15),
        highlightColor: Theme.of(context).primaryColor.withAlpha(30),
        child: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: widget.layoutType == LayoutType.verticallList
                        ? 300
                        : 200,
                    // height: 200,
                    width: widget.layoutType == LayoutType.verticallList
                        ? double.infinity
                        : 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: widget.product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        // Handle favorite action
                        setState(() {
                          like = !like;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          like == true
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart,
                          color: like == true ? Colors.red : Colors.grey,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.product.title,
                style: TextStyle(
                  fontSize:
                      widget.layoutType == LayoutType.grid ||
                          widget.layoutType == LayoutType.horizontalList
                      ? 16
                      : 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10),
              Text(
                formattedPrice(widget.product.previousPrice),
                style: TextStyle(
                  fontSize:
                      widget.layoutType == LayoutType.grid ||
                          widget.layoutType == LayoutType.grid
                      ? 14
                      : 16,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                formattedPrice(widget.product.price),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// --------------------------------------------------------------------------
class BannerWidget extends StatelessWidget {
  final String imageUrl;
  const BannerWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.fill);
  }
}

/// --------------------------------------------------------------------------
class McwAppBarProductList extends StatefulWidget
    implements PreferredSizeWidget {
  /// --------------------------------------------------------------------------
  final ValueChanged<LayoutType> onChangedLayoutType;
  const McwAppBarProductList({super.key, required this.onChangedLayoutType});

  @override
  State<McwAppBarProductList> createState() => _McwAppBarProductListState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(200.0);
}

class _McwAppBarProductListState extends State<McwAppBarProductList> {
  bool selectGrid = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.0),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    CupertinoIcons.back,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
                Text(
                  'کفش های ورزشی',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(child: SizedBox()),
                IconButton(
                  icon: Badge.count(
                    alignment: AlignmentDirectional.centerEnd,
                    backgroundColor: Theme.of(context).primaryColor,
                    count: 3,
                    child: Icon(
                      CupertinoIcons.shopping_cart,
                      size: 30.0,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: Icon(CupertinoIcons.sort_down, size: 30),
                  onPressed: () {
                    // Handle sort action
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ContainerWidgetButtomSheet(
                          onChangedSortType: (value) {
                            setState(() {});
                          },
                          selectedSortType: context
                              .read<ProductListBloc>()
                              .state
                              .sortType,
                        );
                      },
                    );
                  },
                ),
                SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مرتب سازی',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    Text(
                      context.read<ProductListBloc>().state.sortType ==
                              SortType.cheapest
                          ? 'ارزان ترین'
                          : context.read<ProductListBloc>().state.sortType ==
                                SortType.mostExpensive
                          ? 'گران ترین'
                          : context.read<ProductListBloc>().state.sortType ==
                                SortType.popular
                          ? 'محبوب ترین'
                          : context.read<ProductListBloc>().state.sortType ==
                                SortType.newest
                          ? 'جدیدترین'
                          : 'پیش فرض',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                McwVerticalDivider(height: 30, color: Colors.grey.shade300),
                IconButton(
                  icon: Icon(
                    selectGrid == true
                        ? CupertinoIcons.square_grid_2x2
                        : CupertinoIcons.square_list,
                  ),
                  onPressed: () {
                    // Handle grid view action
                    // You can toggle between grid and list view here
                    setState(() {
                      selectGrid = !selectGrid;
                      widget.onChangedLayoutType(
                        selectGrid ? LayoutType.grid : LayoutType.verticallList,
                      );
                    });
                  },
                ),
                SizedBox(width: 4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// --------------------------------------------------------------------------
class ContainerWidgetButtomSheet extends StatefulWidget {
  final ValueChanged<SortType> onChangedSortType;
  final SortType selectedSortType;

  const ContainerWidgetButtomSheet({
    super.key,
    required this.onChangedSortType,
    required this.selectedSortType,
  });

  @override
  State<ContainerWidgetButtomSheet> createState() =>
      _ContainerWidgetButtomSheetState();
}

class _ContainerWidgetButtomSheetState
    extends State<ContainerWidgetButtomSheet> {
  late SortType selectedSortType;

  @override
  void initState() {
    selectedSortType = widget.selectedSortType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'مرتب سازی براساس',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SortWidget(
            title: 'جدیدترین',
            sortType: SortType.newest,
            selectedSortType: selectedSortType,
            onChangedSortType: (SortType value) {
              setState(() {
                widget.onChangedSortType(SortType.newest);
                selectedSortType = value;
              });
              context.read<ProductListBloc>().add(
                ChangeProductListSortTypeEvent(sortType: SortType.newest),
              );
            },
          ),
          SortWidget(
            title: 'محبوب ترین',
            sortType: SortType.popular,
            selectedSortType: selectedSortType,
            onChangedSortType: (SortType value) {
              setState(() {
                widget.onChangedSortType(SortType.popular);
                selectedSortType = value;
              });
              context.read<ProductListBloc>().add(
                ChangeProductListSortTypeEvent(sortType: SortType.popular),
              );
            },
          ),
          SortWidget(
            title: 'ارزان ترین',
            sortType: SortType.cheapest,
            selectedSortType: selectedSortType,
            onChangedSortType: (SortType value) {
              setState(() {
                widget.onChangedSortType(SortType.cheapest);
                selectedSortType = value;
              });
              context.read<ProductListBloc>().add(
                ChangeProductListSortTypeEvent(sortType: SortType.cheapest),
              );
            },
          ),
          SortWidget(
            title: 'گران ترین',
            sortType: SortType.mostExpensive,
            selectedSortType: selectedSortType,
            onChangedSortType: (SortType value) {
              setState(() {
                widget.onChangedSortType(SortType.mostExpensive);
                selectedSortType = value;
              });
              context.read<ProductListBloc>().add(
                ChangeProductListSortTypeEvent(
                  sortType: SortType.mostExpensive,
                ),
              );
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

/// --------------------------------------------------------------------------
class McwVerticalDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double width;
  const McwVerticalDivider({
    super.key,
    required this.height,
    this.color = Colors.grey,
    this.width = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(color: color, height: height, width: width);
  }
}

/// --------------------------------------------------------------------------
class SortWidget extends StatefulWidget {
  final String title;
  final SortType sortType;
  final SortType selectedSortType;
  final ValueChanged<SortType> onChangedSortType;
  const SortWidget({
    super.key,
    required this.title,
    required this.sortType,
    required this.selectedSortType,
    required this.onChangedSortType,
  });

  @override
  State<SortWidget> createState() => _SortWidgetState();
}

class _SortWidgetState extends State<SortWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle search action
        widget.onChangedSortType(widget.sortType);
        Future.delayed(Duration(milliseconds: 300), () {
          // Close the bottom sheet after a delay
          Navigator.pop(context); // Close the bottom sheet
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(child: SizedBox()),
            McwVerticalDivider(
              height: 24,
              color: Colors.grey.shade300,
              width: 1,
            ),
            SizedBox(width: 10),
            Radio(
              visualDensity: VisualDensity.compact,
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Theme.of(context).primaryColor;
                } else {
                  return Colors.grey.shade500;
                }
              }),
              value: widget.sortType,
              groupValue: widget.selectedSortType,
              onChanged: (value) => widget.onChangedSortType(value!),
            ),
          ],
        ),
      ),
    );
  }
}

/// --------------------------------------------------------------------------
class McwFAB extends StatelessWidget {
  final Widget title ;
  final VoidCallback onTapFAB;
  const McwFAB({super.key, required this.title, required this.onTapFAB});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          // Handle add to cart action
          onTapFAB();
        },

        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: title,
          ),
        ),
      ),
    );
  }
}

/// --------------------------------------------------------------------------
class McwButtomSheet extends StatelessWidget {
  const McwButtomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '2,500,000 تومان',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              // Handle add to cart action
            },
            child: Text('افزودن به سبد خرید'),
          ),
        ],
      ),
    );
  }
}

/// --------------------------------------------------------------------------
class McwAppBarProductDetail extends StatefulWidget {
  final String imageUrl;
  const McwAppBarProductDetail({super.key, required this.imageUrl});

  @override
  State<McwAppBarProductDetail> createState() => _McwAppBarProductDetailState();
}

class _McwAppBarProductDetailState extends State<McwAppBarProductDetail> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.4,
      // floating: true,
      // snap: true,
      // stretch: true,
      pinned: true,
      forceElevated: true,
      backgroundColor: Colors.white,
      elevation: 10,
      shadowColor: Colors.black.withAlpha(100),
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: isFavorite == false
              ? Icon(Icons.favorite_border)
              : Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            // Handle favorite action
            setState(() {
              isFavorite = !isFavorite;
            });
          },
        ),
      ],
    );
  }
}

/// --------------------------------------------------------------------------
class CommentWidget extends StatelessWidget {
  final Comment comment;
  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0, right: 16, left: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withAlpha(20)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    comment.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    DateTime.parse(comment.date).toJalaliString(),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              Text(
                'توسط حسین جاوید',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),

              SizedBox(height: 8),
              Text(comment.content, style: TextStyle(fontSize: 14)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star_half, color: Colors.amber),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// --------------------------------------------------------------------------

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CommonAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          context.go('/');
        },
      ),
      actions: [],
      backgroundColor: Colors.white,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}

/// --------------------------------------------------------------------------

class McwElevatedButton extends StatelessWidget {
  final OnTapCallback ontap;
  final ThemeData themeData;
  final String text;

  const McwElevatedButton({
    super.key,
    required this.themeData,
    required this.ontap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(themeData.primaryColor),
        ),
        onPressed: () {
          ontap();
        },
        child: Text(text, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

/// --------------------------------------------------------------------------

class McwTextButton extends StatelessWidget {
  final String text;
  final OnTapCallback onTap;
  const McwTextButton({
    super.key,
    required this.themeData,
    required this.onTap,
    required this.text,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: TextButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
        ),
        onPressed: () {
          onTap();
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: themeData.primaryColor),
        ),
      ),
    );
  }
}

///----------------------------------------------------------------------------

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

///---------------------------------------------------------------------------

// Shimmer placeholders for loading state

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
