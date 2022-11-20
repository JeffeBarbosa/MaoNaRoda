import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:MaoNaRoda/helpers/user.dart';

class HttpService {
  static final String baseUrl = "https://mao-na-roda.herokuapp.com";

  static Future<String> createUser(User user) async {
    Response res = await post(Uri.parse(baseUrl + "/users"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toMap()));

    if (res.statusCode == 201) {
      return "User created!";
    } else {
      throw "Error creating user!";
    }
  }
}
