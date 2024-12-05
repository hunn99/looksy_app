import 'package:looksy_app/domain/entities/service.dart';

class Order {
  final int id;
  final int userId;
  final int barbershopId;
  final String orderDate;
  final String orderTime;
  final double totalPrice;
  String status;
  final List<Item>? services;

  Order({
    required this.id,
    required this.userId,
    required this.barbershopId,
    required this.orderDate,
    required this.orderTime,
    required this.totalPrice,
    required this.status,
    this.services,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      barbershopId: json['barbershop_id'] ?? 0,
      orderDate: json['order_date'] ?? '',
      orderTime: json['order_time'] ?? '',
      totalPrice: (json['total_price'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      services: (json['services'] as List<dynamic>?)
          ?.map((serviceJson) => Item.fromServiceJson(serviceJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'barbershop_id': barbershopId,
      'order_date': orderDate,
      'order_time': orderTime,
      'total_price': totalPrice,
      'status': status,
      'services': services?.map((service) => service.toJson()).toList(),
    };
  }
}
