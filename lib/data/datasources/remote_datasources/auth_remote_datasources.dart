import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final String baseUrl =
      'http://192.168.0.111:8000/api'; // Gunakan base URL yang konsisten

  // Fungsi untuk mendaftarkan pengguna baru
  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode != 201) {
        final responseData = jsonDecode(response.body);
        throw Exception(responseData['error'] ?? 'Unknown error');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  // Fungsi untuk login pengguna
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();

        // Simpan username dan token
        await prefs.setString('username', responseData['user']['username']);
        await prefs.setString('auth_token', responseData['token']);

        return true;
      } else {
        final responseData = jsonDecode(response.body);
        throw Exception(responseData['error'] ?? 'Login failed.');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  // Fungsi untuk logout pengguna
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null) {
      final url = Uri.parse('$baseUrl/logout');
      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode != 200) {
          throw Exception('Logout failed.');
        }

        await prefs.clear();
      } catch (e) {
        throw Exception('Error during logout: $e');
      }
    } else {
      throw Exception('No token found for logout.');
    }
  }
}
