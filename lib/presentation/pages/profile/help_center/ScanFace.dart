import 'package:flutter/material.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class HowToScanFacePage extends StatelessWidget {
  const HowToScanFacePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle bodyTextStyle = TextStyle(fontSize: 16, color: neutralTheme);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'How To Scan Face',
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
                'Follow these steps to scan your face and get hairstyle recommendations:',
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
                '2. Navigate to the "Scan" menu from the main screen.',
                style: bodyTextStyle,
              ),
              SizedBox(height: 8),

              // Step 3
              Text(
                '3. Click on the "Scan" button to start scanning your face.',
                style: bodyTextStyle,
              ),
              Image.asset(
                'assets/images/Scan.png',
                scale: 1.2,
              ),

              // Step 4
              Text(
                '4. Position your face in front of the camera, and it will automatically scan.',
                style: bodyTextStyle,
              ),
              SizedBox(height: 8),

              // Step 5
              Text(
                '5. After scanning, the app will show several hairstyle recommendations based on your face shape.',
                style: bodyTextStyle,
              ),
              Image.asset(
                'assets/images/Scan1.png',
                scale: 1.2,
              ),

              // Step 6
              Text(
                '6. Select the hairstyle you like by clicking on it.',
                style: bodyTextStyle,
              ),
              SizedBox(height: 8),

              // Step 7
              Text(
                '7. A new page will appear showing more information about the selected hairstyle.',
                style: bodyTextStyle,
              ),
              Image.asset(
                'assets/images/Scan2.png',
                scale: 1.2,
              ),

              // Step 8
              Text(
                '8. You can choose to "Save" the hairstyle or directly "Book" an appointment.',
                style: bodyTextStyle,
              ),
              SizedBox(height: 8),

              // Step 9
              Text(
                '9. If you choose to "Book", you will be redirected to the booking page.',
                style: bodyTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
