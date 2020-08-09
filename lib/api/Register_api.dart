import 'dart:convert';

import 'package:http/http.dart' as http;

class Register {
  static Future<dynamic> registerUser(
      String name, String password, String email) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "c_password": password,
    };
    var responce =
        await http.post("https://freshodaily.com/api/register", body: data);
    var jsonData = null;
    if (responce.statusCode == 200) {
      jsonData = json.decode(responce.body);
      return jsonData["success"]["token"];
    } else {
      return false;
    }
  }
}
