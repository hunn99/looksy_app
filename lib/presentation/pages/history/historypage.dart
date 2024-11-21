import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/card/card_history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Daftar orderan
  List<Map<String, dynamic>> orders = [
    {
      'services': 'Premium Haircut, Hair Color',
      'date': '15 Sep 2023',
      'time': '06:30 AM',
      'price': 'Rp. 175.000',
      'status': 'On Process',
      'cancelable': true,
    },
    {
      'services': 'Premium Haircut, Hair Color',
      'date': '15 Sep 2023',
      'time': '06:30 AM',
      'price': 'Rp. 175.000',
      'status': 'On Process',
      'cancelable': true,
    },
    {
      'services': 'Premium Haircut, Hair Color, Hair Color, Shave',
      'date': '12 Sep 2023',
      'time': '06:30 AM',
      'price': 'Rp. 175.000',
      'status': 'Canceled',
      'cancelable': true,
    },
    {
      'services': 'Premium Haircut',
      'date': '12 Aug 2023',
      'time': '07:00 AM',
      'price': 'Rp. 40.000',
      'status': 'Finished',
      'cancelable': true,
    },
  ];

  // Fungsi untuk mengubah status menjadi 'Canceled'
  void cancelOrder(int index) {
    setState(() {
      orders[index]['status'] = 'Canceled';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'History',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: neutralTheme,
          toolbarHeight: 80,
        ),
        body: orders.isEmpty
            ? NoOrdersFound()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: orders
                        .asMap()
                        .entries
                        .map(
                          (entry) => Column(
                            children: [
                              HistoryCard(
                                services: entry.value['services'],
                                date: entry.value['date'],
                                time: entry.value['time'],
                                price: entry.value['price'],
                                status: entry.value['status'],
                                cancelable: entry.value['cancelable'],
                                onCancel: () => cancelOrder(entry.key),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
      ),
    );
  }
}

class NoOrdersFound extends StatelessWidget {
  const NoOrdersFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                IconsaxBold.clipboard_text,
                size: 80,
                color: neutralTheme[200]!,
              ),
              const SizedBox(height: 16),
              const Text(
                'No Orders Found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: neutralTheme,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'There Are No Ongoing Orders At The Moment',
                style: TextStyle(
                  fontSize: 14,
                  color: neutralTheme[300]!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
