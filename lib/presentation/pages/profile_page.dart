import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/gen/assets.gen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(8),
        backgroundColor: Colors.white,
        title: const Text(
          'پروفایل',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.logout_outlined)),
        ],
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(height: 4),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    Image.asset(
                      Assets.img.nikeLogoDark.path,
                      width: 64,
                      height: 64,
                    ),
                    SizedBox(height: 24),
                    Text(
                      'HoseinJavid.dev@gmail.com',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 16),
                    Divider(color: Colors.grey.shade200, height: 1),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => print('tap'),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.heart),
                              SizedBox(width: 4),
                              Text(
                                'لیست علاقه مندی ها',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(color: Colors.grey.shade200, height: 1),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => print('ontap'),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(Icons.shopping_bag_outlined),
                              SizedBox(width: 4),
                              Text(
                                'سوابق سفارش',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(color: Colors.grey.shade200, height: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
