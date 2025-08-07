import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Custom text field widget for email/password input with styling.
class CustomTextFild extends StatelessWidget {
  /// Custom Text Field for email input
  final String hintText;
  final bool obsecureText;
  const CustomTextFild({
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

/// Banner list widget displaying a carousel of banners with page indicator.
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

/// Horizontal product list widget for displaying multiple products.
class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 325,
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
              ),
              ProductWidget(
                imageUrl:
                    'https://s3.ir-thr-at1.arvanstorage.com/nike/legend-react-3-shield-running-shoe-WWzCLk.jpg',
              ),
              ProductWidget(
                imageUrl:
                    'https://s3.ir-thr-at1.arvanstorage.com/nike/legend-react-3-shield-running-shoe-WWzCLk.jpg',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Widget for displaying the title of a product section and a "view all" button.
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

/// Product widget displaying product image, title, price, and favorite icon.
class ProductWidget extends StatefulWidget {
  final String imageUrl;
  const ProductWidget({super.key, required this.imageUrl});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool like = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
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
                    width: 200,
                    height: 200,
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 10,),
              Text(
                '3,500,000 تومان',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                '2,800,000 تومان',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Banner widget for displaying a single banner image.
class BannerWidget extends StatelessWidget {
  final String imageUrl;
  const BannerWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.fill);
  }
}
