import 'dart:convert';

import 'package:final_app/Preferences.dart';
import 'package:final_app/models/Cart.dart';
import 'package:final_app/models/OrderData.dart';
import 'package:http/http.dart' as http;

class CartApi {
  static Future<dynamic> addToCart(String id) async {
    final authtoken = await Preferences.getData("authToken");
    final response = await http.post(
      "https://freshodaily.com/api/add-to-cart",
      body: {
        "product_id": id,
      },
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $authtoken',
      },
    );
    var data = jsonDecode(response.body);
    var responceJson = data["message"];
    return responceJson;
  }

  // https://freshodaily.com/api/cart-list

  static Future<dynamic> cartList() async {
    final authtoken = await Preferences.getData("authToken");
    final response = await http
        .get(Uri.encodeFull("https://freshodaily.com/api/cart-list"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $authtoken',
    });
    var responseJson = jsonDecode(response.body);
    var data = responseJson["data"];
    var message = responseJson["message"];
    if (data != null) {
      int totalCoupons = data.length;
      List<CartData> CategoriesApiDetail = List<CartData>();
      for (int i = 0; i < totalCoupons; i++) {
        CategoriesApiDetail.add(CartData.fromJson(data[i]));
      }
      return CategoriesApiDetail;
    } else {
      return responseJson["message"];
    }
  }

  static Future<dynamic> totalAmount() async {
    final authtoken = await Preferences.getData("authToken");
    final response = await http
        .get(Uri.encodeFull("https://freshodaily.com/api/cart-list"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $authtoken',
    });
    var responseJson = jsonDecode(response.body);
    var data = responseJson["data"];
    var message = responseJson["message"];

    return responseJson["total"];
  }

  static Future<dynamic> deleteCartItemById(String id) async {
    final authtoken = await Preferences.getData("authToken");

    final response = await http.post(
      "https://freshodaily.com/api/delete-single-product-in-cart",
      body: {'id': id.toString()},
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $authtoken',
      },
    );

    return response;
  }

  static Future<dynamic> deleteCart() async {
    final authtoken = await Preferences.getData("authToken");
    final response = await http.get(
      "https://freshodaily.com/api/delete-cart",
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $authtoken',
      },
    );
    return response;
  }

  static Future<dynamic> cartCount() async {
    final authtoken = await Preferences.getData("authToken");
    final response = await http.get(
      "https://freshodaily.com/api/cart-count",
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $authtoken',
      },
    );
    var responseJson = jsonDecode(response.body);
    var data = responseJson["data"];
    return data;
  }

  static Future<dynamic> updateCartItemByIdAdd(
      String id, String quantity) async {
    int quan = int.parse(quantity) + 1;
    String newquan = quan.toString();
    final authtoken = await Preferences.getData("authToken");
    final response = await http.post(
      "https://freshodaily.com/api/update-cart",
      body: {'cart_id': id.toString(), 'quantity': newquan.toString()},
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $authtoken',
      },
    );
    return response;
  }

  static Future<dynamic> updateCartItemByIdSub(
      String id, String quantity) async {
    int quan = int.parse(quantity) - 1;
    if (quan >= 1) {
      String newquan = quan.toString();
      final authtoken = await Preferences.getData("authToken");
      final response = await http.post(
        "https://freshodaily.com/api/update-cart",
        body: {'cart_id': id.toString(), 'quantity': newquan.toString()},
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $authtoken',
        },
      );
      return response;
    }
  }

  static Future<dynamic> orderPlacing(String address, String pin, String mobile,
      String email, String mode) async {
    final authtoken = await Preferences.getData("authToken");
    final response = await http.post(
      "https://freshodaily.com/api/checkout",
      body: {
        'pin': pin.toString(),
        'address': address.toString(),
        'mobile': mobile.toString(),
        'payment_mode': mode.toString(),
        'email': email.toString()
      },
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $authtoken',
      },
    );
    var data = jsonDecode(response.body);
    var responceJson = data["message"];
    return responceJson;
  }

  static Future<dynamic> myOrders() async {
    final authtoken = await Preferences.getData("authToken");
    final response = await http
        .get(Uri.encodeFull("https://freshodaily.com/api/my-orders"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $authtoken',
    });
    var responseJson = jsonDecode(response.body);
    var data = responseJson["data"];
    var message = responseJson["message"];

    if (data != null) {
      int totalCoupons = data.length;
      List<OrderData> CategoriesApiDetail = List<OrderData>();
      for (int i = 0; i < totalCoupons; i++) {
        CategoriesApiDetail.add(OrderData.fromJson(data[i]));
      }
      return CategoriesApiDetail;
    } else {
      return responseJson["message"];
    }
  }
}
