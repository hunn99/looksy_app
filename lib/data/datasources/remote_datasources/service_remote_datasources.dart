import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceServices {
  // Fungsi untuk mengambil layanan dari database
  Future<List<Map<String, dynamic>>> fetchServices() async {
    try {
      // Ambil token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Token tidak ditemukan, harap login kembali');
      }

      // Kirim permintaan ke API
      final url = Uri.parse('http://192.168.0.111:8000/api/services');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Sertakan token
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final services = responseData['data']; // Pastikan struktur JSON benar
        if (services is List) {
          return services.map<Map<String, dynamic>>((service) {
            return {
              'id': service['id'], // Pastikan sesuai dengan struktur API
              'name': service['name'],
              'price': service['price'],
              'selected': false,
            };
          }).toList();
        } else {
          throw Exception('Data layanan tidak valid');
        }
      } else {
        throw Exception('Gagal memuat layanan: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error fetching services: $error');
    }
  }
}
