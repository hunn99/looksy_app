import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/utils/text.dart';

class MenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final int index;
  final selectedPageIndex;
  final Function(int) onTap;

  const MenuItem(
      {super.key,
      required this.label,
      required this.icon,
      required this.index,
      required this.selectedPageIndex,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap(index);
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Icon(
                icon,
                size: 24,
                color: neutralTheme,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: selectedPageIndex == index
                    ? bodyBlack3
                    : bodyBlack3.copyWith(fontWeight: fontWeight["Medium"]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
