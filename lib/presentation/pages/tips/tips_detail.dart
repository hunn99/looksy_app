import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class TipsDetailPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String characteristic; // Characteristic parameter added
  final String description;

  TipsDetailPage({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.characteristic, // Receive characteristic
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: neutralTheme,
          leading: IconButton(
            icon: const Icon(IconsaxOutline.arrow_left, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section with Image and Text
              Container(
                color: neutralTheme,
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imagePath,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subtitle,
                            style: TextStyle(
                                fontSize: 14, color: neutralTheme[300]!),
                          ),
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Characteristic Section with Label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Characteristic', // Label before characteristic
                  style: TextStyle(
                      fontSize: 16,
                      color: neutralTheme[300], // Gray color
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  characteristic, // Display characteristic here
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // "How to Care for 'hair_type' Hair" Label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'How to Care for $title Hair', // Display dynamic hair type
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: neutralTheme,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Body Section with Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
