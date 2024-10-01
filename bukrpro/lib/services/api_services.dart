import 'dart:math';

import 'package:buktorgrow/models/login_model.dart';
import 'package:buktorgrow/services/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String apiUrl = Apis.login; // Replace with your API URL

  Future<bool?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    // Log the response body for debugging

    if (response.statusCode == 200) {
      // Parse the response and convert to LoginModel
      return true;
    } else {
      // Login failed, throw error or handle accordingly
      return null;
    }
  }
}
