import 'package:flutter/material.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class BookBarbershopPage extends StatelessWidget {
  const BookBarbershopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'How To Book Barbershop Services',
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
                'To book a barbershop service, follow these steps:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: neutralTheme),
              ),
              const SizedBox(height: 16),

              // Step 1
              const Text(
                '1. Go to the "Home" menu and find the "Schedule Your Shave" box.',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),
              Image.asset(
                'assets/images/ScheduleYourShave.png',
                scale: 1.2,
              ),

              // Step 2
              const Text(
                '2. Select the date, time, and service.',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),

              // Step 3
              const Text(
                '3. Click "Booking Now" to confirm.',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),

              // Step 4
              const Text(
                '4. Check the "History" menu to confirm your booking.',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),
              Image.asset(
                'assets/images/History.png',
                scale: 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
