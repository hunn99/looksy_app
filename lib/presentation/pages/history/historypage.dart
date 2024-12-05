import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looksy_app/presentation/bloc/order/order_bloc.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/card/card_history.dart';
import 'package:looksy_app/presentation/widgets/modals/dialogcancel.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    // Memanggil FetchOrderHistoryEvent saat halaman dibuka
    context.read<OrderBloc>().add(FetchOrderHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<OrderBloc>().add(FetchOrderHistoryEvent());
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('History', style: heading3White),
            backgroundColor: neutralTheme,
            toolbarHeight: 80,
            leading: null,
          ),
          body: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is OrderFailed) {
                return Center(child: Text(state.errorMessage));
              } else if (state is OrderSuccess) {
                // Navigator.of(context, rootNavigator: true).pop();
                // final orderHistory = context.read<OrderBloc>().orderHistory;

                if (state.order.isEmpty) {
                  return const NoOrdersFound();
                }

                return Container(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    itemCount: state.order.length,
                    itemBuilder: (context, index) {
                      final order = state.order[index];
                      print("Order Data: ${order.toJson()}");
                      return Column(
                        children: [
                          HistoryCard(
                            services: order.services ?? [],
                            date: order.orderDate,
                            time: order.orderTime,
                            price: 'Rp. ${order.totalPrice.toString()}',
                            status: order.status,
                            cancelable:
                                order.status.toLowerCase() == 'on process',
                            onCancel: () {
                              showDialog(
                                context: context,
                                builder: (_) => CancelOrderDialog(
                                  onConfirm: () {
                                    // Panggil event cancel order
                                    context.read<OrderBloc>().add(
                                        CancelOrderEvent(orderId: order.id));
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                        ],
                      );
                    },
                  ),
                );
              }
              return const NoOrdersFound();
            },
          ),
        ),
      ),
    );
  }
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
          Text(
            'There Are No Ongoing Orders At The Moment',
            style: bodyGrey2,
          ),
        ],
      ),
    );
  }
}
