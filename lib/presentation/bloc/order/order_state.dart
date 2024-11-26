part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final Order order;

  const OrderSuccess({required this.order});

  @override
  List<Object?> get props => [order];
}

class OrderFailed extends OrderState {
  final String errorMessage;

  const OrderFailed({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}