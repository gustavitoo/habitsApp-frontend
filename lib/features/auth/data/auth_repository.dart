import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:habits_app/core/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['access_token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return token;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String> register(
    String name,
    String lastName,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.registerEndpoint}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': '$name $lastName',
        'email': email,
        'password': password,
      }),
    );

    print('Login Status Code: ${response.statusCode}');
    print('Login Response Body: ${response.body}');

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['access_token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return token;
    } else {
      final errorBody = response.body;
      throw Exception(
        'Login falló. Código: ${response.statusCode}. Mensaje: $errorBody',
      );
    }
  }
}
