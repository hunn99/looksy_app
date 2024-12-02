import 'package:flutter/material.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:looksy_app/domain/entities/service.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class HistoryCard extends StatelessWidget {
  final List<Item> services;
  final String date;
  final String time;
  final String price;
  final String status;
  final bool cancelable;
  final VoidCallback? onCancel;

  const HistoryCard({
    super.key,
    required this.services,
    required this.date,
    required this.time,
    required this.price,
    required this.status,
    required this.cancelable,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final isCanceled = status.toLowerCase() == 'canceled';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: neutralTheme[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildColumnLeft(isCanceled),
              _buildColumnRight(isCanceled),
            ],
          ),
          const SizedBox(height: 6),
          Divider(color: Colors.grey[300], thickness: 1),
          const SizedBox(height: 6),
          _buildBottomRow(context),
        ],
      ),
    );
  }

  Widget _buildColumnLeft(bool isCanceled) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(IconsaxBold.calendar,
                  size: 24,
                  color: isCanceled ? neutralTheme[300] : neutralTheme),
              const SizedBox(width: 8),
              Text(
                date,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isCanceled ? neutralTheme[300] : neutralTheme,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(IconsaxBold.scissor,
                  size: 24,
                  color: isCanceled ? neutralTheme[300] : neutralTheme),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  services.map((service) => service.name).join(', '),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isCanceled ? neutralTheme[300] : neutralTheme,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColumnRight(bool isCanceled) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(IconsaxBold.clock,
                  size: 24,
                  color: isCanceled ? neutralTheme[300] : neutralTheme),
              const SizedBox(width: 8),
              Text(
                time,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isCanceled ? neutralTheme[300] : neutralTheme,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(IconsaxBold.dollar_circle,
                  size: 24,
                  color: isCanceled ? neutralTheme[300] : neutralTheme),
              const SizedBox(width: 8),
              Text(
                price,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isCanceled ? neutralTheme[300] : neutralTheme,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: getStatusColors(status)['bgColor'],
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: getStatusColors(status)['textColor'],
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (cancelable)
          OutlinedButton(
            onPressed: status.toLowerCase() == 'on process' ? onCancel : null,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: status.toLowerCase() == 'on process'
                    ? redTheme[600]!
                    : neutralTheme[300]!,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: status.toLowerCase() == 'on process'
                    ? redTheme[600]!
                    : neutralTheme[300]!,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Map<String, Color> getStatusColors(String status) {
    if (status.toLowerCase() == 'on process') {
      return {'bgColor': yellowTheme[100]!, 'textColor': yellowTheme[600]!};
    } else if (status.toLowerCase() == 'canceled') {
      return {'bgColor': redTheme[100]!, 'textColor': redTheme[600]!};
    } else {
      return {'bgColor': greenTheme[100]!, 'textColor': greenTheme[600]!};
    }
  }
}
