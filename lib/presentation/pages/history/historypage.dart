// import 'dart:math';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looksy_app/presentation/bloc/order/order_bloc.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/card/card_history.dart';
// import 'package:looksy_app/domain/entities/order.dart'; // Adjust the path accordingly
// import 'package:looksy_app/presentation/pages/home/homepage.dart';
// import 'package:looksy_app/presentation/widgets/form/service_field.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('History', style: heading3White),
          backgroundColor: neutralTheme,
          toolbarHeight: 80,
          leading: null,
        ),
        body: BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
          final orderHistory = context.read<OrderBloc>().orderHistory;

          if (orderHistory.isEmpty) {
            return const NoOrdersFound();
          }

          return Container(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: orderHistory.length,
              itemBuilder: (context, index) {
                final order = orderHistory[index];
                return Column(
                  children: [
                    HistoryCard(
                      services:
                          order.services ?? [], // Menggunakan services yang ada
                      date: order.orderDate,
                      time: order.orderTime,
                      price: 'Rp. ${order.totalPrice.toString()}',
                      status: order.status,
                      cancelable: order.status.toLowerCase() == 'on process',
                      onCancel: () {
                        context
                            .read<OrderBloc>()
                            .add(CancelOrderEvent(orderId: order.id));
                      },
                    ),
                    const SizedBox(
                        height: 12), // Menambahkan jarak setelah setiap item
                  ],
                );
              },
            ),
          );
        }),
      ),
    );
  }

  // Fungsi untuk mengubah status menjadi 'Canceled'
  // void cancelOrder(int index) {
  //   final order = context.read<OrderBloc>().orderHistory[index];
  //   if (order.status != 'Canceled') {
  //     context.read<OrderBloc>().add(CancelOrderEvent(orderId: order.id));
  //   }
  // }
}

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
        Text('There Are No Ongoing Orders At The Moment', style: bodyGrey2),
      ],
    ));
  }
}
