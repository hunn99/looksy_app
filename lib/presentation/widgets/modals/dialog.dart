import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/presentation/utils/theme.dart';


class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              IconsaxOutline.logout,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              "Logout",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Are you sure you want to logout?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: neutralTheme),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Arahkan ke halaman login
                    Navigator.of(context).pop(); // Tutup dialog
                    context.go('/login'); // Navigasi ke halaman login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    "No",
                    style: TextStyle(color: neutralTheme),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
