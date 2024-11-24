import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/text.dart';

class MenuItem extends StatelessWidget {
  final String label;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final int index;
  final int selectedPageIndex;
  final Function(int) onTap;

  const MenuItem(
      {super.key,
      required this.label,
      required this.selectedIcon,
      required this.unselectedIcon,
      required this.index,
      required this.selectedPageIndex,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedPageIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? selectedIcon : unselectedIcon,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(label, style: isSelected ? bodyBlack3 : bodyBlack4),
          ],
        ),
      ),
    );
  }
}
