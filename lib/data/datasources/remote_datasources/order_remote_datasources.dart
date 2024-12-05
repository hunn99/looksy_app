import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:looksy_app/data/dto/requests/order_dto.dart';
import 'package:looksy_app/domain/entities/order.dart' as entities;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:looksy_app/presentation/utils/constants.dart';


class OrderServices {
  // final String baseUrl =
  //     'http://192.168.23.251:8000/api'; // Gunakan base URL yang konsisten
  // Fungsi untuk membuat order
  Future<Either<String, entities.Order>> order(OrderDto params) async {
    final url = Uri.parse('$baseUrl/api/orders');
    try {
      print('1');
      print(url);
      print('2');
      // Cetak data JSON yang akan dikirim
      print(params.date);
      print(params.time);
      print(params.totalPayment);
      print(params.pickedServices);

      final body = jsonEncode(params.toJson());
      print("Data yang dikirim ke backend: $body");
      // Ambil token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        return Right(
            entities.Order.fromJson(jsonDecode(response.body)['data']));
      } else {
        return Left(jsonDecode(response.body)['error']);
      }
    } catch (e) {
      return Left('Error during order: $e');
    }
  }
}
