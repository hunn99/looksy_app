import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:looksy_app/data/dto/requests/login_dto.dart';
import 'package:looksy_app/data/dto/requests/register_dto.dart';
import 'package:looksy_app/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:looksy_app/presentation/utils/constants.dart';

class AuthServices {
  // Fungsi untuk mendaftarkan pengguna baru
  Future<Either<String, User>> register(RegisterDto params) async {
    final url = Uri.parse('$baseUrl/api/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(params.toJson()),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        // print('berhasil');
        final prefs = await SharedPreferences.getInstance();

        // Simpan username dan token
        await prefs.setString(
            'auth_token', jsonDecode(response.body)['data']['token']);
        return Right(User.fromJson(jsonDecode(response.body)['data']['user']));
      } else {
        return Left(jsonDecode(response.body)['error']);
      }
    } catch (e) {
      return Left('Error during register: $e');
    }
  }

  // Fungsi untuk login pengguna
  Future<Either<String, User>> login(LoginDto params) async {
    final url = Uri.parse('$baseUrl/api/login');
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
      final url = Uri.parse('$baseUrl/api/logout');
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

  // Fungsi untuk mengambil data user dari SharedPreferences
  Future<User?> getUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');
    final username = prefs.getString('username');
    final email = prefs.getString('email');
    final photo = prefs.getString('profile_image'); // Ambil URL gambar

    if (username != null && email != null) {
      return User(
        id: id ?? 0,
        username: username,
        email: email,
        photo: photo ?? '',
      );
    }
    return null; // Jika data tidak ditemukan
  }

  // Fungsi untuk memperbarui data pengguna
  Future<Either<String, User>> updateProfile({
    required String username,
    required String email,
    String? photoPath,
  }) async {
    final url = Uri.parse('$baseUrl/api/update-profile');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      // Siapkan data yang akan dikirim
      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['username'] = username
        ..fields['email'] = email;

      // Tambahkan file gambar jika ada
      if (photoPath != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_image',
          photoPath,
        ));
      }

      // Kirim permintaan
      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final updatedUser = User.fromJson(jsonDecode(response.body)['user']);
        // Perbarui data di SharedPreferences
        await prefs.setString('username', updatedUser.username);
        await prefs.setString('email', updatedUser.email);
        if (updatedUser.photo != null) {
          await prefs.setString('profile_image', updatedUser.photo!);
        }
        return Right(updatedUser);
      } else {
        return Left(jsonDecode(response.body)['error']);
      }
    } catch (e) {
      return Left('Error during update: $e');
    }
  }
}
