import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class HairstyleItem extends StatelessWidget {
  final String imageUrl;
  final String hairstyleName;
  final bool isSelected;
  final VoidCallback onSelect; // Callback for selection
  final int index; // Add index to track the card

  const HairstyleItem({
    super.key,
    required this.imageUrl,
    required this.hairstyleName,
    required this.isSelected,
    required this.onSelect,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect, // Trigger the onSelect callback when tapped
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 210,
        width: 174,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: neutralTheme,
          border: Border.all(
            color: isSelected
                ? Colors.white
                : Colors.transparent, // Update border color based on selection
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              hairstyleName,
              style: heading5White,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
