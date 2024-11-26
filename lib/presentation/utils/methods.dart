import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String convertDateFormat(String inputDate) {
  // Define the input and output date formats
  DateFormat inputFormat = DateFormat('dd-MM-yyyy');
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');

  // Parse the input date string and format it to the desired output format
  DateTime dateTime = inputFormat.parse(inputDate);
  return outputFormat.format(dateTime);
}

bool isBarberShopOpen() {
  final now = DateTime.now();
  final start = TimeOfDay(hour: 9, minute: 0); // Jam buka
  final end = TimeOfDay(hour: 21, minute: 59); // Jam tutup

  // Konversi waktu ke menit sejak tengah malam
  int nowMinutes = now.hour * 60 + now.minute;
  int startMinutes = start.hour * 60 + start.minute;
  int endMinutes = end.hour * 60 + end.minute;

  return nowMinutes >= startMinutes && nowMinutes <= endMinutes;
}