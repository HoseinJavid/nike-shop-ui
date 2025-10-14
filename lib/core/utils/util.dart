import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:url_launcher/url_launcher.dart';

String formattedPrice(int price) {
  return '${NumberFormat('#,###').format(price)} تومان';
}

extension JalaliFormatter on DateTime {
  String toJalaliString({String pattern = "EEE dd MMMM yyyy"}) {
    final g = Gregorian(year, month, day);
    final j = g.toJalali();

    return pattern
        .replaceAll("yyyy", j.year.toString())
        // .replaceAll("MM", j.month.toString().padLeft(2, '0'))
        .replaceAll("dd", j.day.toString().padLeft(2, '0'))
        .replaceAll("MMMM", j.formatter.mN)
        .replaceAll("EEE", j.formatter.wN)
        .replaceAll("HH", hour.toString().padLeft(2, '0'))
        .replaceAll("mm", minute.toString().padLeft(2, '0'))
        .replaceAll("ss", second.toString().padLeft(2, '0'));
  }
}

Future<void> openBrowser(String link) async {
  final Uri url = Uri.parse(link);
  if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
    throw 'Could not launch $url';
  }
}

String? validateMobile(String? value) {
  if (value == null || value.isEmpty) {
    return 'پرکردن این فیلد الزامی است';
  }
  final regex = RegExp(r'^\d{10,15}$');
  if (!regex.hasMatch(value)) {
    return 'شماره موبایل نامعتبر است';
  }
  return null;
}

String? validateNotEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return 'پرکردن این فیلد الزامی است';
  }
  return null;
}

String? validatePostalCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'پرکردن این فیلد الزامی است';
  }
  final regex = RegExp(r'^\d{10}$');
  if (!regex.hasMatch(value)) {
    return 'کدپستی نامعتبر است';
  }
  return null;
}

String? validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'پرکردن این فیلد الزامی است';
  }
  if (value.length < 10) {
    return 'آدرس باید حداقل 10 کاراکتر باشد';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'پرکردن این فیلد الزامی است';
  }
  if (value.length < 2) {
    return 'نام باید حداقل 2 کاراکتر باشد';
  }
  return null;
}

String? validateLastName(String? value) {
  if (value == null || value.isEmpty) {
    return 'پرکردن این فیلد الزامی است';
  }
  if (value.length < 2) {
    return 'نام خانوادگی باید حداقل 2 کاراکتر باشد';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'پرکردن این فیلد الزامی است';
  }
  if (value.length < 6) {
    return 'رمز عبور باید حداقل 6 کاراکتر باشد';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'پرکردن این فیلد الزامی است';
  }
  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!regex.hasMatch(value)) {
    return 'ایمیل نامعتبر است';
  }
  return null;
}

String? validateRePassword(String? password, String? rePassword) {
  if (rePassword == null || rePassword.isEmpty) {
    return 'پرکردن این فیلد الزامی است';
  }
  if (password != rePassword) {
    return 'رمز عبور با تکرار آن مطابقت ندارد';
  }
  return null;
}

void navigateFromUri(Uri uri, BuildContext context) {
  final path = uri.path;
  final queryParams = uri.queryParameters;

  if (path == '/verify') {
    final queryString = queryParams.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
    final location = queryString.isEmpty ? path : '$path?$queryString';
    context.go(location);
  }
}
