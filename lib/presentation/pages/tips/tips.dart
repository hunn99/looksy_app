import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/card/card_tip.dart';
import 'tips_detail.dart';

// Simulasi data yang diambil dari database atau API
class HairTip {
  final String title;
  final String subtitle;
  final String imagePath;
  final String characteristic;
  final String description;

  HairTip({
    required this.title,
    required this.imagePath,
    required this.characteristic,
    required this.description,
  }) : subtitle = "Hair Care Tips"; // Subtitle remains constant
}

class TipsPage extends StatelessWidget {
  TipsPage({super.key});

  // Simulasi daftar data tips per jenis rambut (simulating database data with hair_type as title)
  final List<Map<String, String>> hairTipsData = [
    {
      'hair_type': 'Straight',
      'photo': 'assets/images/Straight.jpg',
      'characteristic': 'Sleek and smooth texture',
      'description': 'Straight hair care tips go here...',
    },
    {
      'hair_type': 'Wavy',
      'photo': 'assets/images/Wavy.jpg',
      'characteristic': 'Adds volume and bounce',
      'description': 'Wavy hair care tips go here...',
    },
    {
      'hair_type': 'Curly',
      'photo': 'assets/images/Curly.jpg',
      'characteristic': 'Defines curls with natural shape',
      'description': 'Curly hair care tips go here...',
    },
    {
      'hair_type': 'Frizzy',
      'photo': 'assets/images/Frizzy.jpg',
      'characteristic': 'Tends to be unruly without proper care',
      'description': 'Frizzy hair care tips go here...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Hair Tips Care',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: neutralTheme,
          toolbarHeight: 80,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              childAspectRatio: 0.8,
            ),
            itemCount: hairTipsData.length,
            itemBuilder: (context, index) {
              final tipData = hairTipsData[index];
              final hairTip = HairTip(
                title: tipData['hair_type']!,
                imagePath: tipData['photo']!,
                characteristic: tipData['characteristic']!,  // Add characteristic data
                description: tipData['description']!,
              );

              return TipCard(
                imagePath: hairTip.imagePath,
                title: hairTip.title,
                subtitle: hairTip.subtitle,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TipsDetailPage(
                        title: hairTip.title,
                        subtitle: hairTip.subtitle,
                        imagePath: hairTip.imagePath,
                        characteristic: hairTip.characteristic,  // Pass characteristic
                        description: hairTip.description,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
