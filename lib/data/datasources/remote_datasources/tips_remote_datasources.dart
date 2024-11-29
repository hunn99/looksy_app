import 'package:http/http.dart' as http;
import 'dart:convert';

class TipsServices {
  // URL API yang digunakan untuk mengambil data tips
  final String apiUrl = "http://localhost:8000/api/hair_tips";

  // Fungsi untuk mengambil daftar tips perawatan rambut dari API
  Future<List<Map<String, String>>> fetchHairTips() async {
    try {
      // Mengirim permintaan GET ke API
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        // Mengubah response menjadi JSON
        final responseData = jsonDecode(response.body);

        // Mengecek apakah data sesuai dengan struktur yang diharapkan
        final tipsData = responseData['data'];
        if (tipsData is List) {
          // Mapping data dari API ke List<Map<String, String>>
          return tipsData.map<Map<String, String>>((tip) {
            return {
              'hair_type': tip['hair_type'] ?? '',
              'characteristic_hair': tip['characteristic_hair'] ?? '',
              'description': tip['description'] ?? '',
              'photo': tip['photo'] ?? '',
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
