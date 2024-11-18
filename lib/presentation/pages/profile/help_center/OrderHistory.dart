import 'package:flutter/material.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class HowToSeeOrderHistoryPage extends StatelessWidget {
  const HowToSeeOrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'How to See Barbershop Order History',
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
                'Follow these steps to view your order history:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: neutralTheme),
              ),
              SizedBox(height: 16),

              // Step 1: Go to History
              const Text(
                '1. Open the app and navigate to the "History" menu.',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),
              SizedBox(height: 16),

              // Step 2: View Orders
              const Text(
                '2. In the History menu, you will see a list of your past orders with their current status.',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),
              SizedBox(height: 16),

              // Step 3: Check Status
              const Text(
                '3. Each order will have a status such as "On Process", "Finished", or "Canceled".',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),
              Image.asset(
                'assets/images/Historypage.png',
                scale: 1.2,
              ),

              // Step 4: Cancel Order (If applicable)
              const Text(
                '4. If your order is still "On Process", you can cancel it by pressing the "Cancel" button.',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),
              SizedBox(height: 16),

              const Text(
                '5. If the status is "Finished" or "Canceled", the order is complete and cannot be canceled.',
                style: TextStyle(fontSize: 16, color: neutralTheme),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
