class OrderDto {
  final String date;
  final String time;
  final double totalPayment;
  final List<int> pickedServices; // Tambahkan parameter ini

  OrderDto({
    required this.date,
    required this.time,
    required this.totalPayment,
    required this.pickedServices,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
      'total_payment': totalPayment,
      'services': pickedServices,
    };
  }

  OrderDto copyWith({
    String? date,
    String? time,
    double? totalPayment,
    List<int>? pickedServices,
  }) {
    return OrderDto(
      date: date ?? this.date,
      time: time ?? this.time,
      totalPayment: totalPayment ?? this.totalPayment,
      pickedServices: pickedServices ?? this.pickedServices,
    );
  }
}
