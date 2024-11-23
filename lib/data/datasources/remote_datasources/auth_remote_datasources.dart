import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:looksy_app/data/dto/requests/login_dto.dart';
import 'package:looksy_app/data/dto/requests/register_dto.dart';
import 'package:looksy_app/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final String baseUrl =
      'http://192.168.0.111:8000/api'; // Gunakan base URL yang konsisten

  // Fungsi untuk mendaftarkan pengguna baru
  Future<Either<String, User>> register(RegisterDto params) async {
    final url = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(params.toJson()),
      );
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 201) {
        // print('berhasil');
        final prefs = await SharedPreferences.getInstance();

        // Simpan username dan token
        await prefs.setString('auth_token', jsonDecode(response.body)['token']);
        return Right(User.fromJson(jsonDecode(response.body)['user']));
      } else {
        return Left(jsonDecode(response.body)['error']);
      }
    } catch (e) {
      return Left('Error during register: $e');
    }
  }

  // Fungsi untuk login pengguna
  Future<Either<String, User>> login(LoginDto params) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();

        // Simpan username dan token
        await prefs.setString('auth_token', jsonDecode(response.body)['token']);

        return Right(User.fromJson(jsonDecode(response.body)['user']));
      } else {
        return Left(jsonDecode(response.body)['error']);
      }
    } catch (e) {
      return Left('Error during login: $e');
    }
  }

  // Fungsi untuk logout pengguna
  Future<Either<String, User>> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final url = Uri.parse('$baseUrl/logout');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Hapus token dari SharedPreferences
        await prefs.remove('auth_token');
        return Right(User.fromJson(jsonDecode(response.body)['user']));
      } else {
        return Left(jsonDecode(response.body)['error']);
      }
    } catch (e) {
      return Left('Error during logout: $e');
    }
  }
}
