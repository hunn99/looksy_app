import 'package:flutter/material.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class HowToSeeHairCareTipsPage extends StatelessWidget {
  const HowToSeeHairCareTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle bodyTextStyle = TextStyle(fontSize: 16, color: neutralTheme);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'How To See Hair Care Tips',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: neutralTheme,
          leading: IconButton(
            icon: const Icon(IconsaxOutline.arrow_left, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                'Follow these steps to see hair care tips:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: neutralTheme),
              ),

              // Step 1
              Text(
                '1. Open the app and sign in if needed.',
                style: bodyTextStyle,
              ),
              SizedBox(height: 8),

              // Step 2
              Text(
                '2. Navigate to the "Tips" menu from the main screen.',
                style: bodyTextStyle,
              ),
              Image.asset(
                'assets/images/Tips.jpg',
                scale: 1.2,
              ),
              SizedBox(height: 16),

              // Step 3
              Text(
                '3. Select the hair type that matches your own.',
                style: bodyTextStyle,
              ),
              SizedBox(height: 8),

              // Step 4
              Text(
                '4. A new screen will appear with detailed tips for your hair type.',
                style: bodyTextStyle,
              ),
              Image.asset(
                'assets/images/TipsDetail.jpg',
                scale: 1.2,
              ),
              SizedBox(height: 16),

              // Step 5
              Text(
                '5. Read through the tips to improve your hair care routine!',
                style: bodyTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
