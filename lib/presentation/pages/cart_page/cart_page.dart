import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:practice/data/model/cart_Item.dart';
import 'package:practice/data/model/cart_list.dart';
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
                      child: SvgPicture.asset(
                        Assets.img.emptyCart,
                        placeholderBuilder: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    SizedBox(height: 32),
                    Text('سبد خرید شما خالی هست'),
                  ],
                ),
              ),
            );
          }
          if (state is CartLoading) {
            if (state.type == CartLoadingType.defult) {
              return Scaffold(
                appBar: CommonAppbar(title: 'سبدخرید'),
                floatingActionButton: McwFAB(title: 'پرداخت'),
                body: Center(child: CircularProgressIndicator()),
              );
            }
          }
          if (state is CartLoading) {
            if (state.type == CartLoadingType.itemCountChange) {
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
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount:
                              state.previousState!.cartList.cartItems.length,
                          (context, index) => McwCartItemContainer(
                            cartItem:
                                state.previousState!.cartList.cartItems[index],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(height: 32),
                            Row(children: [Text('جزعیات خرید')]),
                            SizedBox(height: 16),
                            CartInfoWidget(
                              cartList: state.previousState!.cartList,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
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
          if (state is CartLoaded) {
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
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.cartList.cartItems.length,
                        (context, index) => McwCartItemContainer(
                          cartItem: state.cartList.cartItems[index],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(height: 32),
                          Row(children: [Text('جزعیات خرید')]),
                          SizedBox(height: 16),
                          CartInfoWidget(cartList: state.cartList),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class McwCartItemContainer extends StatelessWidget {
  final CartItem cartItem;
  const McwCartItemContainer({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: McwCartItem(cartItem: cartItem),
        ),
      ),
    );
  }
}

class McwCartItem extends StatelessWidget {
  final CartItem cartItem;
  const McwCartItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: cartItem.product.image,
              width: 104,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                cartItem.product.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                SizedBox(
                  width: 136,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context).add(
                            ChangeCartItemCount(
                              cartItem.id,
                              cartItem.count + 1,
                            ),
                          );
                        },
                        icon: Icon(Icons.add_circle_outline, size: 24),
                      ),
                      BlocSelector<CartBloc, CartState, bool>(
                        selector: (state) {
                          if (state is CartLoading) {
                            if (state.type == CartLoadingType.itemCountChange) {
                              if (state.cartItemId == cartItem.id) {
                                return true;
                              }
                            }
                          }
                          return false;
                        },
                        builder: (context, state) {
                          return state == false
                              ? Text(
                                  cartItem.count.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                  ),
                                )
                              : SpinKitThreeBounce(
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                );
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          if (cartItem.count >= 1) {
                            BlocProvider.of<CartBloc>(context).add(
                              ChangeCartItemCount(
                                cartItem.id,
                                cartItem.count - 1,
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          cartItem.count == 1
                              ? Icons.delete_outline
                              : Icons.remove_circle_outline,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '${NumberFormat('#,###').format(cartItem.product.price)} تومان',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  '${NumberFormat('#,###').format(cartItem.product.previousPrice)} تومان',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
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
              onPressed: () {
                BlocProvider.of<CartBloc>(
                  context,
                ).add(RemoveCartItem(cartItem.id));
                BlocProvider.of<CartBloc>(context).add(LoadCart());
              },
              child: Text(
                'حذف از سبد خرید',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CartInfoWidget extends StatelessWidget {
  final CartList cartList;

  final EdgeInsetsGeometry padding;
  const CartInfoWidget({
    super.key,
    this.padding = const EdgeInsets.all(16),
    required this.cartList,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartBloc, CartState, bool>(
      selector: (state) {
        if (state is CartLoading) {
          if (state.type == CartLoadingType.itemCountChange) {
            return true;
          }
        }
        return false;
      },
      builder: (context, state) {
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
                  state == false
                      ? Text(
                          '${NumberFormat('#,###').format(cartList.payablePrice)} تومان',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      : SizedBox(
                          width: 130,
                          child: Center(
                            child: SpinKitThreeBounce(
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
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
                  state == false
                      ? Text(
                          cartList.shippingCost == 0
                              ? 'رایگان'
                              : '${NumberFormat('#,###').format(cartList.shippingCost)} تومان',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      : SizedBox(
                          width: 130,
                          child: Center(
                            child: SpinKitThreeBounce(
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
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
                  state == false
                      ? Text(
                          '${NumberFormat('#,###').format(cartList.totalPrice)} تومان',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        )
                      : SizedBox(
                          width: 130,
                          child: Center(
                            child: SpinKitThreeBounce(
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
