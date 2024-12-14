import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/presentation/pages/profile/save_page.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

import '../../pages/navigation/navigation.dart';

class SaveDialog extends StatelessWidget {
  const SaveDialog({super.key});

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
              IconsaxBold.tick_circle,
              size: 24,
              color: greenTheme,
            ),
            const SizedBox(height: 8),
            Text(
              "Your selected hairstyle recommendation is saved",
              style: heading4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SavePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: greenTheme,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 48, vertical: 12),
                        maximumSize: const Size(double.infinity, 48)),
                    child: Text(
                      "Ok",
                      style: bodyWhite5,
                    ),
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

class SaveBookingDialog extends StatelessWidget {
  const SaveBookingDialog({super.key});

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
              IconsaxBold.tick_circle,
              size: 24,
              color: greenTheme,
            ),
            const SizedBox(height: 8),
            Text(
              "Your selected hairstyle recommendation is saved\nYou can now proceed with booking",
              style: heading4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const NavigationPage(),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: greenTheme,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 48, vertical: 12),
                        maximumSize: const Size(double.infinity, 48)),
                    child: Text(
                      "Ok",
                      style: bodyWhite5,
                    ),
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
