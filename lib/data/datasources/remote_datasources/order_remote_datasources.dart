import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OrderServices {
  // Fungsi untuk membuat order
  Future<void> createOrder({
    required String date,
    required String time,
    required double totalPayment,
    required List<Map<String, dynamic>> pickedServices, // Tambahkan parameter ini
  }) async {
    try {
      // Ambil token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Token tidak ditemukan, harap login kembali');
      }

      // Kirim permintaan ke API
      final url = Uri.parse('http://localhost:8000/api/orders');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Sertakan token autentikasi
        },
        body: jsonEncode({
          'date': date,
          'time': time,
          'total_payment': totalPayment,
          'services': pickedServices.map((service) => service["id"]).toList(),
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        print('Order created successfully');
      } else {
        final responseData = jsonDecode(response.body);
        throw Exception('Gagal membuat order: ${responseData['error'] ?? 'Unknown error'}');
      }
    } catch (error) {
      throw Exception('Error creating order: $error');
    }
  }
}