import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practice/core/constants/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// --------------------------------------------------------------------------
class McwTextFild extends StatelessWidget {
  /// Custom Text Field for email input
  final String hintText;
  final bool obsecureText;
  const McwTextFild({
    super.key,
    required this.hintText,
    this.obsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextField(
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
  const BannerList({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Stack(
      children: [
        SizedBox(
          height: 250,
          child: PageView(
            controller: pageController,
            children: [
              BannerWidget(
                imageUrl:
                    'https://s3.ir-thr-at1.arvanstorage.com/nike/banner_1.jpg',
              ),
              BannerWidget(
                imageUrl:
                    'https://s3.ir-thr-at1.arvanstorage.com/nike/banner_1.jpg',
              ),
              BannerWidget(
                imageUrl:
                    'https://s3.ir-thr-at1.arvanstorage.com/nike/banner_1.jpg',
              ),
            ],
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
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            children: [
              ProductWidget(
                imageUrl:
                    'https://s3.ir-thr-at1.arvanstorage.com/nike/legend-react-3-shield-running-shoe-WWzCLk.jpg',
                layoutType: LayoutType.horizontalList,
              ),
              ProductWidget(
                imageUrl:
                    'https://s3.ir-thr-at1.arvanstorage.com/nike/legend-react-3-shield-running-shoe-WWzCLk.jpg',
                layoutType: LayoutType.horizontalList,
              ),
              ProductWidget(
                imageUrl:
                    'https://s3.ir-thr-at1.arvanstorage.com/nike/legend-react-3-shield-running-shoe-WWzCLk.jpg',
                layoutType: LayoutType.horizontalList,
              ),
              ProductWidget(
                imageUrl:
                    'https://s3.ir-thr-at1.arvanstorage.com/nike/legend-react-3-shield-running-shoe-WWzCLk.jpg',
                layoutType: LayoutType.horizontalList,
              ),
              ProductWidget(
                imageUrl:
                    'https://s3.ir-thr-at1.arvanstorage.com/nike/legend-react-3-shield-running-shoe-WWzCLk.jpg',
                layoutType: LayoutType.horizontalList,
              ),
              ProductWidget(
                imageUrl:
                    'https://s3.ir-thr-at1.arvanstorage.com/nike/legend-react-3-shield-running-shoe-WWzCLk.jpg',
                layoutType: LayoutType.horizontalList,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// --------------------------------------------------------------------------
class TitleProductWidget extends StatelessWidget {
  final String title;
  const TitleProductWidget({super.key, required this.title});

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
            onPressed: () {},
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
  final String imageUrl;
  final LayoutType layoutType;
  const ProductWidget({
    super.key,
    required this.imageUrl,
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
                        imageUrl: widget.imageUrl,
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
                'کفش ورزشی دویدن مخصوص نایکی ایرمکس',
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
                '3,500,000 تومان',
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
                '2,800,000 تومان',
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
                  onPressed: () {},
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
                        return ContainerWidgetButtomSheet();
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
                      'پرفروش ترین',
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
  const ContainerWidgetButtomSheet({super.key});

  @override
  State<ContainerWidgetButtomSheet> createState() =>
      _ContainerWidgetButtomSheetState();
}

class _ContainerWidgetButtomSheetState
    extends State<ContainerWidgetButtomSheet> {
  SortType selectedSortType = SortType.newest;
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
                selectedSortType = value;
              });
            },
          ),
          SortWidget(
            title: 'پرفروش ترین',
            sortType: SortType.bestSelling,
            selectedSortType: selectedSortType,
            onChangedSortType: (SortType value) {
              setState(() {
                selectedSortType = value;
              });
            },
          ),
          SortWidget(
            title: 'ارزان ترین',
            sortType: SortType.cheapest,
            selectedSortType: selectedSortType,
            onChangedSortType: (SortType value) {
              setState(() {
                selectedSortType = value;
              });
            },
          ),
          SortWidget(
            title: 'گران ترین',
            sortType: SortType.mostExpensive,
            selectedSortType: selectedSortType,
            onChangedSortType: (SortType value) {
              setState(() {
                selectedSortType = value;
              });
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
  final String title;
  const McwFAB({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          // Handle add to cart action
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
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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
class McwAppBarProductDetail extends StatelessWidget {
  const McwAppBarProductDetail({super.key});

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
          imageUrl:
              'https://s3.ir-thr-at1.arvanstorage.com/nike/legend-react-3-shield-running-shoe-WWzCLk.jpg',
          fit: BoxFit.cover,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          // Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {
            // Handle favorite action
          },
        ),
      ],
    );
  }
}

/// --------------------------------------------------------------------------
class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key});

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
                    'خیلی شیک وباحاله',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    'چهارشنبه 20 مرداد 1404',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              Text(
                'توسط حسین جاوید',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),

              SizedBox(height: 8),
              Text(
                'این کتونی واقعا عالیه و من ازش خیلی راضی هستم. کیفیت ساخت بسیار بالاست و برای دویدن بسیار راحت است.',
                style: TextStyle(fontSize: 14),
              ),
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
