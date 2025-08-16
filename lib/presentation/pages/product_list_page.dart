import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/presentation/widgets/widgets.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  LayoutType layoutType = LayoutType.grid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onChangedLayoutType: (LayoutType value) {
          // Handle layout type change
          // You can update the state or perform any action based on the layout type
          setState(() {
            // Update the layout type or perform any necessary action
            layoutType = value;
          });
        },
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: GridView.count(
          key: ValueKey(layoutType),
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          crossAxisCount: layoutType == LayoutType.grid ? 2 : 1,
          crossAxisSpacing: 8,
          childAspectRatio: layoutType == LayoutType.grid ? 0.65 : 0.8,
          mainAxisSpacing: layoutType == LayoutType.grid ? 0.0 : 8.0,
        
          children: [
            ProductWidget(
              layoutType: layoutType,
              imageUrl:
                  'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
            ),
            ProductWidget(
              layoutType: layoutType,
              imageUrl:
                  'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
            ),
            ProductWidget(
              layoutType: layoutType,
              imageUrl:
                  'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
            ),
        
            ProductWidget(
              layoutType: layoutType,
              imageUrl:
                  'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
            ),
            ProductWidget(
              layoutType: layoutType,
              imageUrl:
                  'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
            ),
            ProductWidget(
              layoutType: layoutType,
              imageUrl:
                  'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
            ),
            ProductWidget(
              layoutType: layoutType,
              imageUrl:
                  'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
            ),
            ProductWidget(
              layoutType: layoutType,
              imageUrl:
                  'https://s3.ir-thr-at1.arvanstorage.com/nike/air-zoom-pegasus-37-running-shoe-W3gMz9%20(1).jpg',
            ),
          ],
        ),
      ),
    );
  }
}
