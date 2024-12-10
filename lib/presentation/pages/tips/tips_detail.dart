import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/text.dart';
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
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imagePath,
                        height: 220,
                        width: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subtitle,
                          style: bodyGrey2,
                        ),
                        Text(
                          title,
                          style: heading4White,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Characteristic', // Label before characteristic
                      style: heading4Black,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      characteristic, // Display characteristic here
                      style: bodyBlack1,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'How to Care for $title Hair', // Display dynamic hair type
                      style: heading4Black,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: bodyBlack1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
