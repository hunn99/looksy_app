part of 'order_bloc.dart';

@immutable

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

// Event untuk proses order
final class OrderOrderEvent extends OrderEvent {
  final OrderDto params;

  const OrderOrderEvent({required this.params});

  @override
  List<Object?> get props => [
        params.date,
        params.time,
        params.totalPayment,
        params.pickedServices,
      ];
}

class CancelOrderEvent extends OrderEvent {
  final int orderId; // Assuming each order has a unique ID
  const CancelOrderEvent({required this.orderId});
}