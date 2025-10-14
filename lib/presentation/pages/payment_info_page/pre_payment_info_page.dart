import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/core/constants/constant.dart';
import 'package:practice/core/utils/util.dart';
import 'package:practice/data/model/cart_list.dart';
import 'package:practice/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:practice/presentation/pages/cart_page/cart_page.dart';
import 'package:practice/presentation/pages/payment_info_page/bloc/pre_payment_info_bloc.dart';
import 'package:practice/presentation/widgets/widgets.dart';

class PrePaymentInfoPage extends StatefulWidget {
  final CartList cartList;
  const PrePaymentInfoPage({super.key, required this.cartList});

  @override
  State<PrePaymentInfoPage> createState() => _PrePaymentInfoPageState();
}

class _PrePaymentInfoPageState extends State<PrePaymentInfoPage> {
  TextEditingController firstNameController = TextEditingController(
    text: 'hosein',
  );
  TextEditingController lastNameController = TextEditingController(
    text: 'javid',
  );
  TextEditingController postalCodeController = TextEditingController(
    text: '1212111111',
  );
  TextEditingController addressCotroller = TextEditingController(
    text: 'qom niroqah city',
  );
  TextEditingController mobileController = TextEditingController(
    text: '09124555555',
  );
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppbar(
          title: 'انتخاب تحویل گیرنده و شیوه پرداخت',
          onTapBack: () {
            context.go('/carPage');
          },
        ),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Color(0xfff4f4f4),
                  height: 8,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 12),
                            TextFormField(
                              validator: (value) => validateName(value),
                              controller: firstNameController,
                              decoration: InputDecoration(labelText: 'نام'),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              validator: (value) => validateLastName(value),
                              controller: lastNameController,
                              decoration: InputDecoration(
                                labelText: ' نام خانوادگی',
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              validator: (value) => validateMobile(value),
                              controller: mobileController,
                              decoration: InputDecoration(
                                labelText: 'شماره تماس',
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              validator: (value) => validateAddress(value),
                              controller: addressCotroller,
                              decoration: InputDecoration(
                                labelText: 'آدرس تحویل گیرنده',
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              validator: (value) => validatePostalCode(value),
                              controller: postalCodeController,
                              decoration: InputDecoration(labelText: 'کدپستی'),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text('جزعیات خرید', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 16),
                      CartInfoWidget(
                        padding: EdgeInsetsGeometry.all(16),
                        cartList: widget.cartList,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child:
                            BlocConsumer<
                              PrePaymentInfoBloc,
                              PrePaymentInfoState
                            >(
                              listener: (context, state) async {
                                if (state is SucsessPrePay) {
                                  context.read<CartBloc>().add(LoadCart());
                                  if (state.response.paymentMethod ==
                                      'online') {
                                    openBrowser(state.response.bankGatewayUrl);
                                    await Future.delayed(Durations.medium2);
                                    context.pop();
                                  } else {
                                    context.pushReplacement(
                                      '/codConfrimationResult',
                                      extra: {
                                        'price': widget.cartList.payablePrice,
                                        'isSuccess': true,
                                        'orderId': state.response.orderId,
                                      },
                                    );
                                  }
                                } else if (state is PaymentProcessError) {
                                  context.read<CartBloc>().add(LoadCart());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      key: UniqueKey(),
                                      content: Text(
                                        state.message,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: McwTextButton(
                                        themeData: themeData,
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<PrePaymentInfoBloc>(
                                              context,
                                            ).add(
                                              StartInitPrePay(
                                                firstNameController.text,
                                                lastNameController.text,
                                                int.parse(
                                                  postalCodeController.text,
                                                ),
                                                addressCotroller.text,
                                                'cod',
                                                mobileController.text,
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                key: UniqueKey(),
                                                content: Text(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  'لطفا فیلد ها را پر کنید',
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        },
                                        widget: state is PaymentProcessLoading
                                            ? CircularProgressIndicator(
                                                color: themeData.primaryColor,
                                              )
                                            : Text(
                                                'پرداخت درمحل',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: themeData.primaryColor,
                                                ),
                                              ),
                                      ),
                                    ),
                                    SizedBox(width: 24),
                                    Expanded(
                                      child: McwElevatedButton(
                                        themeData: themeData,
                                        ontap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<PrePaymentInfoBloc>(
                                              context,
                                            ).add(
                                              StartInitPrePay(
                                                firstNameController.text,
                                                lastNameController.text,
                                                int.parse(
                                                  postalCodeController.text,
                                                ),
                                                addressCotroller.text,
                                                'online',
                                                mobileController.text,
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                key: UniqueKey(),
                                                content: Text(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  'لطفا فیلد ها را پر کنید',
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                          // context.pop();
                                        },
                                        widget: state is PaymentProcessLoading
                                            ? CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : Text(
                                                'پرداخت اینترنتی',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
