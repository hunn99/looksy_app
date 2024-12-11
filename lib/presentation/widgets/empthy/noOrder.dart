import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class NoOrdersFound extends StatelessWidget {
  const NoOrdersFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconsaxBold.clipboard,
            size: 80,
            color: neutralTheme[200]!,
          ),
          const SizedBox(height: 8),
          Text('No Orders Found', style: heading4Black),
          const SizedBox(height: 4),
          Text(
            'There Are No Ongoing Orders At The Moment',
            style: bodyGrey2,
          ),
        ],
      ),
    );
  }
}