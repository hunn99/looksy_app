import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class CancelOrderDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  const CancelOrderDialog({super.key, required this.onConfirm});

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
              IconsaxBold.warning_2,
              size: 24,
              color: redTheme,
            ),
            const SizedBox(height: 8),
            Text(
              "Cancel Order",
              style: heading4Black,
            ),
            const SizedBox(height: 4),
            Text(
              "Are you sure you want to cancel this order?",
              style: bodyGrey5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onConfirm(); // Jalankan aksi konfirmasi
                    Navigator.of(context).pop(); // Tutup dialog
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
