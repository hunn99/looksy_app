import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class TipCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const TipCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gambar
            imagePath.isNotEmpty
                ? Expanded(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(
                        imagePath, // Menampilkan gambar dari URL
                        fit: BoxFit.cover,
                        width: double.infinity, // Mengisi lebar
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.expectedTotalBytes != 0
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : 0
                                    : null,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  )
                : Container(
                    height: 120, // Placeholder jika tidak ada gambar
                    color: Colors.grey[300],
                    child:
                        const Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
            // Deskripsi dan Judul
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: neutralTheme[300]!),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
