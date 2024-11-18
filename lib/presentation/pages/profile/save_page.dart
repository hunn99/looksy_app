import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class SavePage extends StatelessWidget {
  const SavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Save',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          backgroundColor: neutralTheme,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(IconsaxOutline.arrow_left, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Jumlah kolom
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: hairstyles.length,
            itemBuilder: (context, index) {
              return HairstyleCard(hairstyle: hairstyles[index]);
            },
          ),
        ),
      ),
    );
  }
}

class HairstyleCard extends StatelessWidget {
  final Hairstyle hairstyle;

  const HairstyleCard({Key? key, required this.hairstyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                hairstyle.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hairstyle",
                  style: TextStyle(
                    fontSize: 12,
                    color: neutralTheme[300]!,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hairstyle.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(IconsaxBold.archive_1,
                        size: 24, color: neutralTheme),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Hairstyle {
  final String name;
  final String imageUrl;

  Hairstyle({required this.name, required this.imageUrl});
}

// Daftar gaya rambut untuk ditampilkan di halaman "Save"
final List<Hairstyle> hairstyles = [
  Hairstyle(name: "Buzzcut", imageUrl: "assets/images/Wavy.jpg"),
  Hairstyle(name: "Mohawk", imageUrl: "assets/images/Wavy.jpg"),
  Hairstyle(name: "Low Fade", imageUrl: "assets/images/Wavy.jpg"),
  Hairstyle(name: "High Fade", imageUrl: "assets/images/Wavy.jpg"),
  Hairstyle(name: "Crew Cut", imageUrl: "assets/images/Wavy.jpg"),
  Hairstyle(name: "Pompadour", imageUrl: "assets/images/Wavy.jpg"),
  Hairstyle(name: "Undercut", imageUrl: "assets/images/Wavy.jpg"),
  Hairstyle(name: "Quiff", imageUrl: "assets/images/Wavy.jpg"),
];
