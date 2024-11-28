import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class HairstyleDetailPage extends StatefulWidget {
  final String faceShape;
  final String hairstyleName;
  final String imageUrl;
  final String characteristics;
  final String faceSuitability;
  final String maintenance;
  final String impression;

  const HairstyleDetailPage({
    Key? key,
    required this.faceShape,
    required this.hairstyleName,
    required this.imageUrl,
    required this.characteristics,
    required this.faceSuitability,
    required this.maintenance,
    required this.impression,
  }) : super(key: key);

  @override
  _HairstyleDetailPageState createState() => _HairstyleDetailPageState();
}

class _HairstyleDetailPageState extends State<HairstyleDetailPage> {
  bool isSaved = false; // Status penyimpanan gaya rambut

  @override
  void initState() {
    super.initState();
    // Cek apakah gaya rambut sudah disimpan atau belum
    isSaved = savedHairstyles.contains(widget.hairstyleName);
  }

  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
      if (isSaved) {
        savedHairstyles.add(widget.hairstyleName);
      } else {
        savedHairstyles.remove(widget.hairstyleName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: neutralTheme,
        leading: IconButton(
          icon: const Icon(IconsaxOutline.arrow_left, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isSaved ? IconsaxOutline.archive_1 : IconsaxBold.archive_1,
              size: 24.0,
              color: Colors.white,
            ),
            onPressed: toggleSave, // Fungsi untuk menyimpan atau menghapus
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: neutralTheme,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.imageUrl,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Face Shape",
                          style: TextStyle(
                              fontSize: 14, color: neutralTheme[300]!),
                        ),
                        Text(
                          widget.faceShape,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Hairstyle",
                          style: TextStyle(
                              fontSize: 14, color: neutralTheme[300]!),
                        ),
                        Text(
                          widget.hairstyleName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildSection(
                title: "Characteristics", content: widget.characteristics),
            _buildSection(
                title: "Face Suitability", content: widget.faceSuitability),
            _buildSection(title: "Maintenance", content: widget.maintenance),
            _buildSection(title: "Impression", content: widget.impression),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, color: neutralTheme[300]!),
          ),
          const SizedBox(height: 8.0),
          Text(
            content,
            style: const TextStyle(fontSize: 18, color: neutralTheme),
          ),
        ],
      ),
    );
  }
}

List<String> savedHairstyles =
    []; // Daftar untuk menyimpan gaya rambut yang disave
