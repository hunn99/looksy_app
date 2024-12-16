import 'dart:convert';
import 'package:dartz/dartz.dart' as dartz;
import 'package:http/http.dart' as http;
import 'package:looksy_app/domain/entities/hairstyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:looksy_app/presentation/utils/constants.dart';

class HairstyleRemoteDatasources {
  Future<dartz.Either<String, List<HairStyle>>> getSavedHairstyles() async {
    final url = Uri.parse('$baseUrl/api/get-hairlist');
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

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        final hairstyles = data.map((e) => HairStyle.fromJson(e)).toList();
        print(data);
        return dartz.Right(hairstyles);
      } else {
        return dartz.Left(jsonDecode(response.body)['error']);
      }
    } catch (e) {
      return dartz.Left('Error fetching order history: $e');
    }
  }

  Future<dartz.Either<String, HairStyle>> saveHairstyle(int hairstyleId) async {
    final url = Uri.parse('$baseUrl/api/save-hairlist');
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      print(jsonEncode({
        'hairstyle_id': hairstyleId,
      }));

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'hairstyle_id': hairstyleId,
        }),
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        return dartz.Right(
            HairStyle.fromJson(jsonDecode(response.body)['data']));
      } else {
        final error =
            jsonDecode(response.body)['error'] ?? 'Failed to save hairstyle';
        return dartz.Left(error);
      }
    } catch (e) {
      return dartz.Left('Error save hairstyle: $e');
    }
  }
}
