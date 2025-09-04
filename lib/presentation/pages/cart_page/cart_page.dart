import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/gen/assets.gen.dart';
import 'package:practice/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:practice/presentation/widgets/widgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add(LoadCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartEmpty) {
            return Scaffold(
              appBar: CommonAppbar(title: 'سبدخرید'),
              body: SizedBox.expand(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: SvgPicture.asset(Assets.img.emptyCart),
                      ),
                      SizedBox(height: 32),
                      Text('سبد خرید شما خالی هست'),
                    ],
                  ),
                ),
            );
          }
          if (state is CartLoading) {
            return Scaffold(
              appBar: CommonAppbar(title: 'سبدخرید'),
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is CartError) {
            if (state.type == CartErrorType.notLoggedIn) {
              return Scaffold(
                appBar: CommonAppbar(title: 'سبدخرید'),
                body: SizedBox.expand(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: SvgPicture.asset(Assets.img.authRequired),
                      ),
                      SizedBox(height: 32),
                      Text(state.message),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/auth');
                        },
                        child: Text('ورود به حساب کاربری'),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return Scaffold(
            floatingActionButton: McwFAB(title: 'پرداخت'),
            backgroundColor: Color(0xfff4f4f4),
            appBar: CommonAppbar(title: 'سبدخرید'),
            body: Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                top: 8,
                bottom: 8,
              ),
              child: SizedBox.expand(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://s3.ir-thr-at1.arvanstorage.com/nike/legend-react-3-shield-running-shoe-WWzCLk.jpg',
                                  width: 104,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'کفش رانینگ نایک مدل Legend React 3 Shield',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'تعداد',
                                      style: TextStyle(
                                        height: 0.1,
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            size: 24,
                                          ),
                                        ),
                                        Text(
                                          '2',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            size: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '3,500,000 تومان',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      '2,500,000 تومان',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Divider(color: Colors.grey.shade300, thickness: 1),
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'حذف از سبد خرید',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(children: [Text('جزعیات خرید')]),
                    SizedBox(height: 16),
                    CartInfoWidget(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CartInfoWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  const CartInfoWidget({super.key, this.padding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مبلغ کل خرید',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '1,200,000 تومان',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(color: Colors.grey.shade300, thickness: 1),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'هزینه ارسال',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'رایگان',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(color: Colors.grey.shade300, thickness: 1),
          SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مبلغ نهایی',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '5,200,000 تومان',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
