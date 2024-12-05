import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              IconsaxOutline.logout,
              size: 24,
              color: redTheme,
            ),
            const SizedBox(height: 8),
            Text(
              "Logout",
              style: heading4Black,
            ),
            const SizedBox(height: 4),
            Text(
              "Are you sure you want to logout?",
              style: bodyGrey5,
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
                    backgroundColor: redTheme,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 12),
                  ),
                  child: Text(
                    "Yes",
                    style: bodyWhite5,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    side: BorderSide(color: neutralTheme[100]!),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 12),
                  ),
                  child: Text(
                    "No",
                    style: bodyBlack5,
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
