import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Preferences.dart';

class Login {
  static Future<dynamic> LoginUser(String email, String password) async {
    final response = await http.post(
      "https://freshodaily.com/api/login",
      body: jsonEncode(
        <String, String>{
          'email': email,
          'password': password,
        },
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var data = jsonDecode(response.body);
    var responseJson = data["success"];

    if (data.containsKey("success")) {
      Preferences.setUser(
        data["data"]["email"],
        data["data"]["name"],
        responseJson["token"],
      );
      return data["data"]["id"].toInt();
    } else {
      return data["error"];
    }
  }

  static Future<dynamic> LogoutUser() async {
    final authtoken = await Preferences.getData("authToken");

    final response = await http.get(
      "https://freshodaily.com/api/logout",
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $authtoken',
      },
    );
    Preferences.removeUser();
    return jsonDecode(response.body);
  }
}
