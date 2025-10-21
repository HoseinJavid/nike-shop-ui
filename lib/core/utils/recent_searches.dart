import 'package:flutter/material.dart';
import 'package:practice/data/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String keyRecent = 'recent_searches';
const int maxItems = 10;

Future<void> submitRecentSearchHistory(String q) async {
  final prefs = await SharedPreferences.getInstance();
  final list = prefs.getStringList(keyRecent) ?? <String>[];

  // move existing to top or add new
  list.remove(q);
  list.insert(0, q);

  // trim
  if (list.length > maxItems) list.removeRange(maxItems, list.length);

  await prefs.setStringList(keyRecent, list);
}

Future<List<String>> _getRecentSearchHistory() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(keyRecent) ?? <String>[];
}

Future<void> _removeRecentSearchHistory(String q) async {
  final prefs = await SharedPreferences.getInstance();
  final list = prefs.getStringList(keyRecent) ?? <String>[];
  list.remove(q);
  await prefs.setStringList(keyRecent, list);
}

Future<void> clearRecentSearchHistory() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(keyRecent);
}

Future<List<Product>> getRecentSearchHistory(List<Product> products) async {
  var recentSearchTitle = await _getRecentSearchHistory();
  List<Product> tmp = [];
  for (var product in products) {
    for (var title in recentSearchTitle) {
      if (product.title == title) {
        tmp.add(product);
      }
    }
  }
  return tmp;
}

Future<List<Product>> removeRecentSearchHistory(
  String q,
  List<Product> products,
) async {

  await _removeRecentSearchHistory(q);
  for (var product in products) {
    if (product.title == q) {
      products.remove(product);
      break;
    }
  }
  return products;
}
