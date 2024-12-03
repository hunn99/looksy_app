import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:looksy_app/data/datasources/remote_datasources/order_remote_datasources.dart';
import 'package:looksy_app/data/datasources/remote_datasources/history_remote_datasources.dart';
import 'package:looksy_app/data/dto/requests/order_dto.dart';
import 'package:looksy_app/domain/entities/order.dart';

part 'order_state.dart';
part 'order_event.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderServices orderServices;
  final HistoryRemoteDataSource historyRemoteDataSource;

  // Daftar riwayat order
  final List<Order> _orderHistory = [];

  List<Order> get orderHistory => List.unmodifiable(_orderHistory);

  OrderBloc({
    required this.orderServices,
    required this.historyRemoteDataSource, // Tambahkan parameter ini
  }) : super(OrderInitial()) {
    // Event untuk melakukan order
    on<OrderOrderEvent>(
      (event, emit) async {
        emit(OrderLoading());

        final response = await orderServices.order(OrderDto(
          date: event.params.date,
          time: event.params.time,
          totalPayment: event.params.totalPayment,
          pickedServices: event.params.pickedServices,
        ));

        response.fold((l) => emit(OrderFailed(errorMessage: l)), (r) {
          _orderHistory.add(r); // Tambahkan order ke daftar riwayat
          emit(OrderSuccess(order: _orderHistory));
        });
      },
    );

    // Event untuk membatalkan order
    on<CancelOrderEvent>((event, emit) async {
      emit(OrderLoading());
      
      final response = await historyRemoteDataSource.cancelOrder(event.orderId);

      response.fold(
        (error) => emit(OrderFailed(errorMessage: error)),
        (success) {
          if (success) {
            final orderIndex =
                _orderHistory.indexWhere((order) => order.id == event.orderId);
            if (orderIndex != -1) {
              _orderHistory[orderIndex].status = 'Canceled';
              emit(OrderSuccess(order: _orderHistory));
            }
          } else {
            emit(OrderFailed(errorMessage: 'Failed to update order status.'));
          }
        },
      );
    });

    // Event untuk mengambil riwayat order
    on<FetchOrderHistoryEvent>(
      (event, emit) async {
        emit(OrderLoading());

        final response = await historyRemoteDataSource.getOrderHistory();

        response.fold(
          (error) => emit(OrderFailed(errorMessage: error)),
          (orders) {
            _orderHistory.clear(); // Kosongkan riwayat lama
            _orderHistory.addAll(orders); // Tambahkan riwayat baru
            emit(OrderSuccess(order: _orderHistory));
          },
        );
      },
    );
  }
}
