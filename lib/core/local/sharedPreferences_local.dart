import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences _shprefs;
Future<SharedPreferences> initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  _shprefs = sharedPreferences;
  return _shprefs;
}
