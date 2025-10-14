import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/core/utils/util.dart';
import 'package:practice/presentation/widgets/widgets.dart';

class CodConfrimResultPage extends StatelessWidget {
  final int price;
  final bool isSuccess;
  final int orderId;
  const CodConfrimResultPage({
    super.key,
    required this.price,
    required this.isSuccess,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppbar(title: 'وضعیت سفارش', onTapBack: () {}),
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
                      isSuccess
                          ? 'سفارش باموفقیت ثبت شد'
                          : 'ثبت سفارش ناموفق بود',
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
                          isSuccess ? 'تایید شد' : 'تاییدنشد',
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
                          formattedPrice((price)),
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
                        Text('شناسه سفارش', style: TextStyle(fontSize: 16)),
                        Text(
                          orderId.toString(),
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
                            onTap: () {
                              // context.push('/orderHistory');
                            },
                            widget: Text(
                              'سوابق تراکنش',
                              style: TextStyle(
                                fontSize: 16,
                                color: themeData.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        McwElevatedButton(
                          themeData: themeData,
                          ontap: () {
                            context.go('/');
                          },
                          widget: Text(
                            'بازگشت به صفحه اصلی',
                            style: TextStyle(fontSize: 14),
                          ),
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
