import 'package:flutter/material.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class HowToUseAppPage extends StatelessWidget {
  const HowToUseAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'How To Use This App',
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
                'Follow these steps to use the app:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: neutralTheme),
              ),

              // Step 1
              const Text(
                '1. Open the app and sign in or create an account if you are a new user.',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),

              // Step 2
              const Text(
                '2. Navigate to the "Home" menu to access all available services and options.',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),
              Image.asset(
                'assets/images/Home.png',
                scale: 1.2,
              ),
              SizedBox(height: 16),

              // Step 3
              const Text(
                '3. To book a service, go to "Schedule Your Shave" and select your preferences.',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),

              Image.asset(
                'assets/images/ScheduleYourShave.png',
                scale: 1.2,
              ),
              SizedBox(height: 16),

              // Step 4
              const Text(
                '4. Access tips and guides by navigating to the "Tips" section in the menu.',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),

              Image.asset(
                'assets/images/Tips.jpg',
                scale: 1.2,
              ),
              SizedBox(height: 16),

              // Step 5
              const Text(
                '5. Manage your account settings, including changing your password, in the "Profile" menu.',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),

              Image.asset(
                'assets/images/profile_page1.png',
                scale: 1.2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
