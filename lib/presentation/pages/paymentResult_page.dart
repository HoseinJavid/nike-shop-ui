import 'package:flutter/material.dart';
import 'package:practice/presentation/pages/PaymentInfo_page.dart';
import 'package:practice/presentation/widgets/widgets.dart';

class PaymentResultPage extends StatelessWidget {
  const PaymentResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppbar(title: 'رسیدپرداخت'),
        body: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Color(0xfff4f4f4),
                height: 8,
                width: double.infinity,
              ),
              SizedBox(height: 64),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  children: [
                    Text(
                      'پرداخت باموفقیت انجام شد',
                      style: TextStyle(
                        color: themeData.primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('وضعیت سفارش', style: TextStyle(fontSize: 16)),
                        Text(
                          'پرداخت شده',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('مبلغ', style: TextStyle(fontSize: 16)),
                        Text(
                          '1,249,000 تومان',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Divider(thickness: 0.9),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: McwTextButton(
                            themeData: themeData,
                            onTap: () {},
                            text: 'سوابق تراکنش',
                          ),
                        ),
                        SizedBox(width: 16),
                        McwElevatedButton(
                          themeData: themeData,
                          ontap: () {},
                          text: 'بازگشت به صفحه اصلی ',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
