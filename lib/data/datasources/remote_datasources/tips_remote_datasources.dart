import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TipsServices {
  final baseUrl = 'http://192.168.64.142:8000/storage';

  // Fungsi untuk mengambil daftar tips perawatan rambut dari API
  Future<List<Map<String, dynamic>>> fetchHairTips() async {
    try {
      // Ambil token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Token tidak ditemukan, harap login kembali');
      }
      final url = Uri.parse('http://192.168.64.142:8000/api/tips');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Sertakan token
        },
      );

      if (response.statusCode == 200) {
        // Mengubah response menjadi JSON
        final responseData = jsonDecode(response.body);
        final tipsData = responseData['data'];
        if (tipsData is List) {
          return tipsData.map<Map<String, dynamic>>((tips) {
            return {
              'hair_type': tips['hair_type'],
              'characteristic_hair': tips['characteristic_hair'],
              'description': tips['description'],
              'photo': '$baseUrl/${tips['photo']}',
            };
          }).toList();
        } else {
          throw Exception('Data tips tidak valid.');
        }
      } else {
        throw Exception('Gagal memuat data tips: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error fetching hair tips: $error');
    }
  }
}
