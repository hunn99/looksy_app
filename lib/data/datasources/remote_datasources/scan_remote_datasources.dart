import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:looksy_app/domain/entities/hairstyle.dart';
import 'package:looksy_app/presentation/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Pastikan 'baseUrlFlask' ada di sini
// import 'package:shared_preferences/shared_preferences.dart';

class ScanServices {
  // Fungsi untuk mendeteksi wajah dengan Flask
  Future<Map<String, dynamic>> detectFace(String imagePath) async {
    try {
      // Endpoint Flask
      final url = Uri.parse('$baseUrlFlask/upload');

      // Buat request multipart untuk mengirim file
      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('the_file', imagePath));

      // Kirim request ke API
      var response = await request.send();

      print('response flask');
      print(response.statusCode);

      // Pastikan respons sukses
      if (response.statusCode == 200) {
        // Parse stream respons ke string
        final responseBody = await response.stream.bytesToString();

        // Decode JSON respons dan mengembalikan hasil sebagai map
        return json.decode(responseBody) as Map<String, dynamic>;
      } else {
        throw Exception(
            'Gagal mendeteksi wajah. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fungsi untuk mendapatkan bentuk wajah dari Flask
  Future<String> getFaceShapeFromFlask(File imageFile) async {
    try {
      final response = await detectFace(imageFile.path);

      // Mengambil face shape dari hasil response Flask
      return response["Detected Face Shape"] ??
          ''; // Default jika tidak ada face shape
    } catch (e) {
      throw Exception('Gagal mendapatkan face shape dari Flask: $e');
    }
  }

  // Fungsi untuk mendapatkan hairstyle dari Laravel berdasarkan face shape
  Future<Either<String, List<HairStyle>>> getHairstylesFromLaravel(
      String faceShape) async {
    try {
      print('mulai laravel');
      // Endpoint Laravel untuk mendapatkan hairstyle berdasarkan face shape
      final url = Uri.parse('$baseUrl/api/hairstyle-recommendation');
      print(url);

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      print(faceShape);
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'face_shape': faceShape, // Kirim data bentuk wajah
        },
      );

      print(response.statusCode);
      print(response.body);

      // Pastikan response sukses
      if (response.statusCode == 200) {
        // Decode the JSON response
        final responseData = json.decode(response.body)['data'];
        print(responseData);

        // Parse the list of hairstyles directly
        final List<HairStyle> hairstyles = (responseData as List)
            .map((json) => HairStyle.fromJson(json))
            .toList();
        return right(hairstyles);
      } else {
        return left(
            'Gagal mendapatkan hairstyle. Status: ${response.statusCode}');
      }
    } catch (e) {
      return left('Error mendapatkan hairstyle dari Laravel: $e');
    }
  }
}
