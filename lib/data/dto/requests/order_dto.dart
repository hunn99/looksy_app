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
      'time': _convertTimeTo24HourFormat(time),
      'total_payment': totalPayment,
      'services': pickedServices,
    };
  }

  String _convertTimeTo24HourFormat(String time12Hour) {
    final timeParts = time12Hour.split(" ");
    final hourMinute = timeParts[0].split(":");
    int hour = int.parse(hourMinute[0]);
    final minute = hourMinute[1];
    final isPM = timeParts[1].toUpperCase() == 'PM';

    if (isPM && hour != 12) {
      hour += 12;
    } else if (!isPM && hour == 12) {
      hour = 0;
    }

    return '${hour.toString().padLeft(2, '0')}:$minute';
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
