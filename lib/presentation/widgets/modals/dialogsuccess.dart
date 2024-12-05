import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/presentation/pages/navigation/navigation.dart';
import 'package:looksy_app/presentation/pages/onboarding/login.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

import '../../bloc/order/order_bloc.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

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
              "Order Success",
              style: heading4Black,
            ),
            const SizedBox(height: 4),
            Text(
              "You can view your order on the history page",
              style: bodyGrey5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print('click');
                      Navigator.pop(context);
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
