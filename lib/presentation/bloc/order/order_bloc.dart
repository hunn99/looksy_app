import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:looksy_app/data/datasources/remote_datasources/order_remote_datasources.dart';
import 'package:looksy_app/data/dto/requests/order_dto.dart';
import 'package:looksy_app/domain/entities/order.dart';

part 'order_state.dart';
part 'order_event.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderServices orderServices;

  // Daftar riwayat order
  final List<Order> _orderHistory = [];

  List<Order> get orderHistory => List.unmodifiable(_orderHistory);

  OrderBloc({required this.orderServices}) : super(OrderInitial()) {
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
          _orderHistory.add(r); //Tambahkan order ke daftar riwayat
          emit(OrderSuccess(order: r));
        });
      },
    );
  }
}
