import 'dart:convert';

import 'package:final_app/Preferences.dart';
import 'package:final_app/models/AllProducts.dart';
import 'package:final_app/models/Categories.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CategoriesList {
  static Future<List<CategoriesApi>> categoriesListing() async {
    final authtoken = await Preferences.getData("authToken");
    final response = await http.get(
        Uri.encodeFull("https://freshodaily.com/api/categories"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authtoken',
        });
    var responseJson = jsonDecode(response.body);
    List data = responseJson["data"];
    int totalCoupons = data.length;
    List<CategoriesApi> CategoriesApiDetail = List<CategoriesApi>();
    for (int i = 0; i < totalCoupons; i++) {
      CategoriesApiDetail.add(CategoriesApi.fromJson(data[i]));
    }

    return CategoriesApiDetail;
  }

  static Future<List<CategoriesApi>> subCategoriesById(String id) async {
    final authtoken = await Preferences.getData("authToken");
    debugPrint(id);
    final response = await http.get(
        Uri.encodeFull("https://freshodaily.com/api/sub-categories/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authtoken',
        });
    var responseJson = jsonDecode(response.body);
    var data = responseJson["data"];

    int totalCoupons = data.length;
    List<CategoriesApi> CategoriesApiDetail = List<CategoriesApi>();
    for (int i = 0; i < totalCoupons; i++) {
      CategoriesApiDetail.add(CategoriesApi.fromJson(data[i]));
    }
    return CategoriesApiDetail;
  }

  static Future<List<CategoriesApi>> subCategoriesListing() async {
    final authtoken = await Preferences.getData("authToken");
    final response = await http.get(
        Uri.encodeFull("https://freshodaily.com/api/sub-categories"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authtoken',
        });
    var responseJson = jsonDecode(response.body);
    List data = responseJson["data"];
    int totalCoupons = data.length;
    List<CategoriesApi> CategoriesApiDetail = List<CategoriesApi>();
    for (int i = 0; i < totalCoupons; i++) {
      CategoriesApiDetail.add(CategoriesApi.fromJson(data[i]));
    }

    return CategoriesApiDetail;
  }

  static Future<List<Data>> TrendingNowListing() async {
    final authtoken = await Preferences.getData("authToken");
    final response = await http.get(
        Uri.encodeFull("https://freshodaily.com/api/all-products"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authtoken',
        });
    var responseJson = jsonDecode(response.body);
    List data = responseJson["data"];
    int totalCoupons = data.length;
    List<Data> DataDetail = List<Data>();
    for (int i = 0; i < totalCoupons; i++) {
      DataDetail.add(Data.fromJson(data[i]));
    }

    return DataDetail;
  }
}
