import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/presentation/widgets/widgets.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: GridView.count(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        childAspectRatio: 0.65,

        // crossAxisCount: 1,
        // crossAxisSpacing: 8,
        // childAspectRatio: 0.8,
        // mainAxisSpacing: 8,
        children: [
          ProductWidget(
            layoutType: LayoutType.grid,
            imageUrl:
                'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
          ),
          ProductWidget(
            layoutType: LayoutType.grid,
            imageUrl:
                'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
          ),
          ProductWidget(
            layoutType: LayoutType.grid,
            imageUrl:
                'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
          ),

          ProductWidget(
            layoutType: LayoutType.grid,
            imageUrl:
                'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
          ),
          ProductWidget(
            layoutType: LayoutType.grid,
            imageUrl:
                'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
          ),
          ProductWidget(
            layoutType: LayoutType.grid,
            imageUrl:
                'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
          ),
          ProductWidget(
            layoutType: LayoutType.grid,
            imageUrl:
                'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
          ),
          ProductWidget(
            layoutType: LayoutType.grid,
            imageUrl:
                'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

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
                  icon: Icon(
                    CupertinoIcons.shopping_cart,
                    size: 30.0,
                    color: Colors.black,
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
                              SearchWidget(title: 'جدیدترین'),
                              SearchWidget(title: 'پرفروش ترین'),
                              SearchWidget(title: 'ارزان ترین'),
                              SearchWidget(title: 'گران ترین'),
                              SizedBox(height: 16),
                            ],
                          ),
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
                CustomVerticalDivider(height: 30, color: Colors.grey.shade300),
                IconButton(
                  icon: Icon(CupertinoIcons.square_grid_2x2),
                  onPressed: () {},
                ),
                SizedBox(width: 4),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(200.0);
}

class CustomVerticalDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double width;
  const CustomVerticalDivider({
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

class SearchWidget extends StatefulWidget {
  final String title;
  const SearchWidget({super.key, required this.title});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle search action
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(child: SizedBox()),

            CustomVerticalDivider(
              height: 24,
              color: Colors.grey.shade300,
              width: 1,
            ),
            SizedBox(width: 10),
            Icon(
              CupertinoIcons.check_mark_circled_solid,
              color: isSelected == true
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade400,
              size: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
