import 'package:looksy_app/domain/entities/service.dart';

class Order {
  final int id;
  final int userId;
  final int barbershopId;
  final String orderDate;
  final String orderTime;
  final double totalPrice;
  String status;
  final List<Item>? services; // Jika ada data terkait services

  Order({
    required this.id,
    required this.userId,
    required this.barbershopId,
    required this.orderDate,
    required this.orderTime,
    required this.totalPrice,
    required this.status,
    required this.services,
  });

  /// Factory method untuk membuat objek `Order` dari JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      barbershopId: json['barbershop_id'],
      orderDate: json['order_date'],
      orderTime: json['order_time'],
      totalPrice: (json['total_price'] as num).toDouble(),
      status: json['status'],
      services: (json['services'] as List<dynamic>?)
            ?.map((e) => Item.fromJson(e['service'] as Map<String, dynamic>))
            .toList(),
    );
  }

  /// Mengonversi objek `Order` menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'barbershop_id': barbershopId,
      'order_date': orderDate,
      'order_time': orderTime,
      'total_price': totalPrice,
      'status': status,
      'services': services,
    };
  }
}
