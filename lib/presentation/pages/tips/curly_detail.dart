import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class CurlyDetailPage extends StatelessWidget {
  const CurlyDetailPage({super.key});

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
                        "assets/images/Curly.jpg",
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
                            "Curly",
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
                      "Curly hair is characterized by its natural twists, waves, or coils, which give it unique texture and volume. "
                      "Due to its shape, curly hair is often more prone to dryness, frizz, and breakage, as natural oils from the scalp struggle to reach the ends. "
                      "This hair type typically requires extra moisture and gentle handling to maintain its definition and health.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "How to Care for Curly Hair",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '1. Choose the Right Haircut\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'A suitable cut can enhance natural curls with minimal daily maintenance. Consult with a stylist to find the best haircut for your curl type.\n\n',
                          ),
                          TextSpan(
                            text: '2. Shampoo Less Often\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Wash your hair 2-3 times a week to maintain natural moisture and avoid excessive dryness.\n\n',
                          ),
                          TextSpan(
                            text:
                                '3. Use Curl-Friendly Shampoo and Conditioner\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Select products that moisturize and control frizz. Apply a curl-taming cream after towel-drying to keep curls defined.\n\n',
                          ),
                          TextSpan(
                            text: '4. Try Co-Washing\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Use a curl-specific conditioner as a gentle cleanser instead of shampoo occasionally, to help retain moisture.\n\n',
                          ),
                          TextSpan(
                            text: '5. Upgrade Your Styling Products\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Choose lightweight styling products like curl serums or mousses that define curls without buildup or stiffness.\n\n',
                          ),
                          TextSpan(
                            text: '6. Air Dry or Use a Diffuser\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Avoid heat tools when possible. Use a diffuser to dry curls gently and add volume.\n\n',
                          ),
                          TextSpan(
                            text: '7. Deep Condition Regularly\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Incorporate a deep conditioner into your weekly routine to provide the extra hydration curls need.\n\n',
                          ),
                          TextSpan(
                            text: '8. Additional Care Tips\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Use a microfiber towel to reduce friction, a wide-tooth comb to detangle, and sleep on a silk or satin pillowcase to minimize breakage and preserve curl structure overnight.\n\n',
                          ),
                          TextSpan(
                            text:
                                'With the right care routine, your curls will look defined, soft, and healthy every day.\n',
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
