import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class FrizzDetailPage extends StatelessWidget {
  const FrizzDetailPage({super.key});

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
                        "assets/images/Frizzy.jpg",
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
                            "Frizzy",
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
                      "Frizzy hair refers to hair that appears puffy, stands out from the scalp, and lacks smoothness. It often results from dryness, "
                      "excessive moisture absorption, and hair damage. The hair cuticle lifts, causing strands to separate and create a frizzy look. "
                      "Curly or wavy hair types are more prone to frizz, but it can affect all hair types, especially in humid conditions.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "How to Care for Frizzy Hair",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '1. Choose a Hydrating Shampoo\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Opt for a hydrating shampoo to retain moisture and prevent frizz. Follow up with a conditioner to further smoothen your hair.\n\n',
                          ),
                          TextSpan(
                            text: '2. Use Cold Water to Shower\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Hot water can strip moisture from your hair. Instead, use lukewarm or cool water to rinse your hair to avoid frizz.\n\n',
                          ),
                          TextSpan(
                            text: '3. Choose Styling Methods Carefully\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Avoid tight hairstyles. Instead, embrace natural textures, use alcohol-free gels, or apply a touch-up cream to tame frizz.\n\n',
                          ),
                          TextSpan(
                            text: '4. Use Oil\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Hair oils such as coconut or argan oil can help hydrate your hair, reducing frizz and flyaways.\n\n',
                          ),
                          TextSpan(
                            text: '5. Prevent Damage\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Limit heat exposure, wash hair less frequently, and trim regularly to prevent split ends and dryness.\n\n',
                          ),
                          TextSpan(
                            text: '6. Use Frizz-Fighting Products\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Invest in products like anti-frizz serum, leave-in conditioner, and frizz-fighting gels to control your hair’s texture.\n\n',
                          ),
                          TextSpan(
                            text:
                                'Following these steps can help reduce frizz and maintain healthier, smoother hair.\n',
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
