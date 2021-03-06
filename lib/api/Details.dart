import 'dart:convert';
import 'package:final_app/models/Details.dart';
import 'package:http/http.dart' as http;

class ProductDetil {
  static Future<Detail> getProductbyId(String id) async {
    final response = await http.get(
        Uri.encodeFull("https://freshodaily.com/api/subcategory-products/$id"),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body);

    var responseJson = data["data"][0];
    return Detail.fromJson(responseJson);
  }
}
