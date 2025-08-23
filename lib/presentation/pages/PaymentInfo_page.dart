import 'package:flutter/material.dart';
import 'package:practice/core/constants/constant.dart';
import 'package:practice/presentation/pages/cart_page.dart';
import 'package:practice/presentation/widgets/widgets.dart';

class PaymentInfoPage extends StatelessWidget {
  const PaymentInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppbar(title: 'انتخاب تحویل گیرنده و شیوه پرداخت'),
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
                      SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'نام و نام خانوادگی',
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'شماره تماس'),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'آدرس تحویل گیرنده',
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'کدپستی'),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text('جزعیات خرید', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 16),
                      CartInfoWidget(padding: EdgeInsetsGeometry.all(16)),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Divider(color: Colors.grey.shade300, thickness: 1),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: McwTextButton(
                                themeData: themeData,
                                onTap: () {},
                                text: 'پرداخت درمحل',
                              ),
                            ),
                            SizedBox(width: 24),
                            Expanded(
                              child: McwElevatedButton(
                                themeData: themeData,
                                ontap: () {},
                                text: 'پرداخت اینترنتی',
                              ),
                            ),
                          ],
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


