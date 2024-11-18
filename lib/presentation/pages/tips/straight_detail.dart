import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class StraightDetailPage extends StatelessWidget {
  const StraightDetailPage({super.key});

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
              Container(
                color: neutralTheme,
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/Straight.jpg",
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
                            "Hair Care Tips",
                            style: TextStyle(
                                fontSize: 14, color: neutralTheme[300]!),
                          ),
                          const Text(
                            "Straight",
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Straight hair is smooth, sleek, and lays flat against the scalp. It typically lacks natural curls or waves, "
                      "with a consistent texture from root to tip. Straight hair tends to be shinier and less prone to frizz compared to curly hair. "
                      "However, it can sometimes look flat or lifeless if not properly maintained.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "How to Care for Straight Hair",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '1. Wash and Condition\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Shampoo every 2-3 days and use conditioner to restore moisture. A clarifying shampoo can help remove dirt and oils.\n\n',
                          ),
                          TextSpan(
                            text: '2. Dry and Brush\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Pat hair dry to avoid breakage and brush twice a day—morning and evening—for smoothness.\n\n',
                          ),
                          TextSpan(
                            text: '3. Use Styling Products\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Use lightweight products like pomade for a polished, manageable look.\n\n',
                          ),
                          TextSpan(
                            text: '4. Blow Dry with Cold Air\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'After air-drying, use cool air from a blow dryer to set and straighten your hair.\n\n',
                          ),
                          TextSpan(
                            text: '5. Wrap Your Hair\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Wrap your hair before bed to keep it straight and reduce friction while sleeping.\n\n',
                          ),
                          TextSpan(
                            text: '6. Avoid Chlorine\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Chlorine can dry and damage straight hair. Wet your hair and apply conditioner before swimming.\n\n',
                          ),
                          TextSpan(
                            text: '7. Consider a Slick Back Undercut\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'A slick back undercut works well with straight hair, providing a sharp and easy-to-style look.\n\n',
                          ),
                        ],
                      ),
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
