import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class NoRecommendationFound extends StatelessWidget {
  const NoRecommendationFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        color: neutralTheme,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconsaxBold.emoji_sad,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text('No Hairstyle Found', style: heading3White),
            const SizedBox(height: 4),
            Text(
              'There are no face shape detected, please try capturing the image again',
              style: bodyGrey2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
