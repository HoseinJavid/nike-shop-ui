import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences shprefs;
Future<void> initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  shprefs = sharedPreferences;
}
