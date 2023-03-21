import 'dart:convert';

import 'package:amir/core/enums/api_responses.dart';
import 'package:amir/core/services/call_api.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<ApiResponses> SignUp(
      {required String name,
      required String lastname,
      required String email,
      required String password,
      required String role}) async {
    try {
      var body = jsonEncode({'email': email, 'password': password, 'name': name, 'last_name': lastname, 'role': role});
      http.Response response = await CallApi().postData('register', body);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponses.success;
      } else
        return ApiResponses.usedEmail;
    } catch (e) {
      return ApiResponses.errorOccured;
    }
  }

  Future<ApiResponses> SignIn({
    required String email,
    required String password,
  }) async {
    try {
      var body = jsonEncode({
        'email': email,
        'password': password,
      });
      http.Response response = await CallApi().postData('login', body);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponses.success;
      } else if (result['message'] == 'no user with the provided cridentials') {
        return ApiResponses.wrongCridentials;
      } else {
        return ApiResponses.wrongPassword;
      }
    } catch (e) {
      return ApiResponses.errorOccured;
    }
  }
}
