import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String baseUrl = 'https://localhost:7087';

  static const FlutterSecureStorage _storage =
  FlutterSecureStorage();

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = _decodeResponse(response);

    if (response.statusCode == 200) {
      await _saveAccessToken(data);
      return data;
    }

    if (response.statusCode == 401) {
      throw Exception('Invalid email or password');
    }

    throw Exception(
      data['message'] ?? 'LOGIN_ERROR',
    );
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      }),
    );

    final data = _decodeResponse(response);

    if (response.statusCode == 201) {
      await _saveAccessToken(data);
      return data;
    }

    if (response.statusCode == 409) {
      throw Exception('EMAIL_ALREADY_REGISTERED');
    }

    if (response.statusCode == 400) {
      throw Exception('VALIDATION_ERROR');
    }

    throw Exception(
      data['message'] ?? 'REGISTER_ERROR',
    );
  }

  static Future<Map<String, dynamic>> getCurrentStudent() async {
    final token = await getAccessToken();

    if (token == null || token.isEmpty) {
      throw Exception('NO_TOKEN');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/students/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final data = _decodeResponse(response);

    if (response.statusCode == 200) {
      return data;
    }

    if (response.statusCode == 401) {
      await logout();
      throw Exception('UNAUTHORIZED');
    }

    throw Exception(
      data['message'] ?? 'STUDENT_ERROR',
    );
  }

  static Future<Map<String, dynamic>> getHome() async {
    final token = await getAccessToken();

    if (token == null || token.isEmpty) {
      throw Exception('NO_TOKEN');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/home'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final data = _decodeResponse(response);

    if (response.statusCode == 200) {
      return data;
    }

    if (response.statusCode == 401) {
      await logout();
      throw Exception('UNAUTHORIZED');
    }

    throw Exception(
      data['message'] ?? 'HOME_ERROR',
    );
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(
      key: 'accessToken',
    );
  }

  static Future<void> logout() async {
    await _storage.delete(
      key: 'accessToken',
    );
  }

  static Future<void> _saveAccessToken(
      Map<String, dynamic> data,
      ) async {
    final accessToken = data['accessToken'];

    if (accessToken == null ||
        accessToken.toString().isEmpty) {
      throw Exception('Access token is missing.');
    }

    await _storage.write(
      key: 'accessToken',
      value: accessToken.toString(),
    );
  }

  static Map<String, dynamic> _decodeResponse(
      http.Response response,
      ) {
    if (response.body.isEmpty) {
      return {};
    }

    try {
      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      return {};
    } catch (_) {
      return {};
    }
  }
}