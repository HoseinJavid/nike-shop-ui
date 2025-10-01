import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/core/utils/util.dart';
import 'package:practice/data/model/product.dart';
import 'package:practice/presentation/pages/product_detail_page/bloc/product_detail_bloc.dart';
import 'package:practice/presentation/widgets/widgets.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    context.read<ProductDetailBloc>().add(
      LoadCommets(productId: widget.product.id),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: McwFAB(title: 'افزودن به سبدخرید'),
        body: CustomScrollView(
          slivers: [
            McwAppBarProductDetail(imageUrl: widget.product.image),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(width: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              formattedPrice(widget.product.previousPrice),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              formattedPrice(widget.product.price),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      style: TextStyle(fontSize: 16),
                      'این کتونی شدیدا برای دویدن و راه رفتن مناسب است وتقریبا هیچ فشارمخربی رو به زانوان شما وارد نمیکند',
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'نظرات کاربران',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'ثبت نظر ',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<ProductDetailBloc, ProductDetailState>(
              builder: (context, state) {
                if (state is LoadingCommets) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  );
                } else if (state is ErrorLoadCommets) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: McwShowError(
                        state: state,
                        heightContainer: 200,
                        widthContainer: MediaQuery.of(context).size.width,
                        onTryAgain: () => context.read<ProductDetailBloc>().add(
                          LoadCommets(productId: widget.product.id),
                        ),
                      ),
                    ),
                  );
                } else if (state is LoadedCommets) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.commets.length,
                      (context, index) => CommentWidget(comment: state.commets[index],),
                    ),
                  );
                }
                return SliverToBoxAdapter(child: Container());
              },
            ),
          ],
        ),
      ),
    );
  }
}
