import 'package:flutter/material.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class HowToChangePasswordPage extends StatelessWidget {
  const HowToChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle bodyTextStyle = TextStyle(fontSize: 16, color: neutralTheme);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'How To Change A Password',
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
                'Follow these steps to change your password:',
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
                '2. Navigate to the "Profile" menu from the main screen.',
                style: bodyTextStyle,
              ),
              Image.asset(
                'assets/images/profile.png',
                scale: 1.1,
              ),
              SizedBox(height: 16),

              // Step 3
              Text(
                '3. Click on "Change Password".',
                style: bodyTextStyle,
              ),
              Image.asset(
                'assets/images/Changepass.jpg',
                scale: 2.0,
              ),
              SizedBox(height: 16),

              // Step 4
              Text(
                '4. Fill out the form with your current password, new password, and confirm the new password.',
                style: bodyTextStyle,
              ),
              SizedBox(height: 8),

              // Step 5
              Text(
                '5. Click "Save" to update your password.',
                style: bodyTextStyle,
              ),
              Image.asset(
                'assets/images/Save.jpg',
                scale: 2.0,
              ),
              SizedBox(height: 16),

              // Step 6
              Text(
                '6. Your password has now been changed successfully!',
                style: bodyTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
