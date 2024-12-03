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
    // Tangani `services` sebagai string atau list
    final servicesRaw = json['services'];
    List<Item>? services;

    if (servicesRaw is String) {
      // Jika string, pecah menjadi list berdasarkan koma
      services = servicesRaw
          .split(',')
          .map((service) => Item(id: 0, name: service.trim(), price: 0))
          .toList();
    } else if (servicesRaw is List) {
      // Jika list, proses seperti biasa
      services = servicesRaw
          .map((e) => Item.fromJson(e['service'] as Map<String, dynamic>))
          .toList();
    }

    return Order(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      barbershopId: json['barbershop_id'] ?? 0,
      orderDate: json['date'] ?? '',
      orderTime: json['time'] ?? '',
      totalPrice: _convertPriceToDouble(json['price']),
      status: json['status'] ?? 'Unknown',
      services: services,
    );
  }

  // Mengonversi harga menjadi double
  static double _convertPriceToDouble(String price) {
    return double.tryParse(price.replaceAll(RegExp(r'[Rp.\s]'), '').replaceAll(',', '.')) ?? 0.0;
  }

  /// Mengonversi objek `Order` menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,	
      'barbershop_id': barbershopId,
      'date': orderDate,
      'time': orderTime,
      'price': totalPrice,
      'status': status,
      'services': services,
    };
  }
}
