import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

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
