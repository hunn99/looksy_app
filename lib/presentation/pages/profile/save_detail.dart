import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/domain/entities/hairstyle.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class SaveDetailPage extends StatefulWidget {
  final HairStyle hairstyle;
  const SaveDetailPage({super.key, required this.hairstyle});

  @override
  State<SaveDetailPage> createState() => SaveDetailPageState();
}

class SaveDetailPageState extends State<SaveDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Hairstyle Detail',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: neutralTheme,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              IconsaxOutline.arrow_left,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              height: 240,
              width: double.infinity,
              color: neutralTheme,
              child: Row(
                children: [
                  Container(
                    height: double.infinity,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: NetworkImage(widget.hairstyle.photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Face Shape",
                          style: bodyGrey2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.hairstyle.faceShape,
                          style: heading3White,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Hairstyle",
                          style: bodyGrey2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.hairstyle.hairStyle,
                          style: heading3White,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Characteristics',
                              style: bodyGrey2,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.hairstyle.characteristics,
                              style: heading4Black,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Face Suitability',
                              style: bodyGrey2,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.hairstyle.faceSuitability,
                              style: heading4Black,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Maintenance',
                              style: bodyGrey2,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.hairstyle.maintenance,
                              style: heading4Black,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Impression',
                              style: bodyGrey2,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.hairstyle.impression,
                              style: heading4Black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
