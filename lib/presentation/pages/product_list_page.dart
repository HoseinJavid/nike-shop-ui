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

