import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class WavyDetailPage extends StatelessWidget {
  const WavyDetailPage({super.key});

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
                        "assets/images/Wavy.jpg",
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
                            "Wavy",
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
                      "Wavy hair is characterized by natural waves that fall somewhere between straight and curly hair. "
                      "It has a noticeable texture with soft, loose waves that form a gentle 'S' shape. Wavy hair can be prone to frizz, "
                      "but it offers more volume and body compared to straight hair, making it versatile for various hairstyles.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "How to Care for Wavy Hair",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '1. Shampoo Your Hair Every Third Day\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Shampoo and condition every third day to prevent dryness. Use a leave-in cream conditioner and a hair mask weekly for added moisture.\n\n',
                          ),
                          TextSpan(
                            text: '2. Establish a Good Hair Routine\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'A consistent routine helps maintain the texture and health of your wavy hair.\n\n',
                          ),
                          TextSpan(
                            text:
                                '3. Style with Fingers or a Wide Tooth Comb\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Use a wide-tooth comb to set the curls and then shape with your fingers. Avoid pulling your hair.\n\n',
                          ),
                          TextSpan(
                            text: '4. Avoid Tight Hairstyles\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Avoid tight styles that flatten your waves, as wavy hair looks best when it has natural volume.\n\n',
                          ),
                          TextSpan(
                            text: '5. Use Moisturizing Products\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Opt for moisturizing shampoos, conditioners, and styling products to keep your waves hydrated and defined.\n\n',
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
