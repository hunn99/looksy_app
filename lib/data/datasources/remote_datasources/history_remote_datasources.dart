import 'dart:convert';
import 'package:dartz/dartz.dart' as dartz;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:looksy_app/domain/entities/order.dart';
import 'package:looksy_app/presentation/utils/constants.dart';

class HistoryRemoteDataSource {
  Future<dartz.Either<String, List<Order>>> getOrderHistory() async {
    final url = Uri.parse('$baseUrl/api/history');
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print('Response Data: $body');
        final List<dynamic> data = jsonDecode(response.body)['data'];
        final orders = data.map((e) => Order.fromJson(e)).toList();
        return dartz.Right(orders);
      } else {
        return dartz.Left(jsonDecode(response.body)['error']);
      }
    } catch (e) {
      return dartz.Left('Error fetching order history: $e');
    }
  }

  Future<dartz.Either<String, bool>> cancelOrder(int orderId) async {
    final url = Uri.parse('$baseUrl/api/history/cancel/$orderId');
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return dartz.Right(true);
      } else {
        final error =
            jsonDecode(response.body)['error'] ?? 'Failed to cancel order';
        return dartz.Left(error);
      }
    } catch (e) {
      return dartz.Left('Error canceling order: $e');
    }
  }
}
