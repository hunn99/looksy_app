import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'History',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: neutralTheme,
          toolbarHeight: 80,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              HistoryCard(
                title: 'Premium Haircut, Hair Co...',
                date: '15 Sep 2023',
                time: '06:30 AM',
                price: 'Rp. 175.000',
                status: 'On Process',
                statusColor: yellowTheme,
              ),
              SizedBox(height: 12),
              HistoryCard(
                title: 'Premium Haircut, Hair Co...',
                date: '12 Sep 2023',
                time: '06:30 AM',
                price: 'Rp. 175.000',
                status: 'Canceled',
                statusColor: redTheme,
              ),
              SizedBox(height: 12),
              HistoryCard(
                title: 'Premium Haircut',
                date: '12 Aug 2023',
                time: '07:00 AM',
                price: 'Rp. 40.000',
                status: 'Finished',
                statusColor: greenTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String price;
  final String status;
  final Color statusColor;

  const HistoryCard({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.price,
    required this.status,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: neutralTheme[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(
            color: neutralTheme[100]!,
            thickness: 1,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(IconsaxBold.calendar, size: 20, color: neutralTheme),
              const SizedBox(width: 8),
              Text(
                date,
                style: TextStyle(
                  fontSize: 14,
                  color: neutralTheme[300]!,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(IconsaxBold.clock, size: 20, color: neutralTheme),
              const SizedBox(width: 8),
              Text(
                time,
                style: TextStyle(
                  fontSize: 14,
                  color: neutralTheme[300]!,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(IconsaxBold.dollar_circle,
                  size: 20, color: neutralTheme),
              const SizedBox(width: 8),
              Text(
                price,
                style: TextStyle(
                  fontSize: 14,
                  color: neutralTheme[300]!,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (status == 'On Process')
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: redTheme,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  'Canceled',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
