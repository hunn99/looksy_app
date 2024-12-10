// import 'dart:async';
import 'dart:io';
// import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:looksy_app/data/datasources/remote_datasources/scan_remote_datasources.dart';
import 'package:looksy_app/domain/entities/hairstyle.dart'; // Sesuaikan dengan model Anda

part 'scan_state.dart';
part 'scan_event.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final ScanServices
      scanServices; // Service untuk komunikasi dengan Flask dan Laravel

  ScanBloc({required this.scanServices}) : super(ScanInitial()) {
    // Event untuk upload gambar dan mendapatkan hasil face shape serta hairstyle
    on<UploadImageEvent>(
      (event, emit) async {
        emit(ScanLoading());

        try {
          print('test');
          // Step 1: Kirim gambar ke Flask untuk mendeteksi face shape
          final faceShape =
              await scanServices.getFaceShapeFromFlask(event.imageFile);

          print(faceShape);

          // Jika face shape kosong, tampilkan error
          if (faceShape.isEmpty) {
            emit(const ScanFailed('Gagal mendeteksi bentuk wajah.'));
            return;
          }

          // // Step 2: Kirim face shape ke Laravel untuk mendapatkan hairstyle
          final response =
              await scanServices.getHairstylesFromLaravel(faceShape);

          response.fold(
            (l) => emit(ScanFailed(l)),
            (r) => emit(ScanSuccess(hairstyles: r)),
          );
        } catch (e) {
          emit(ScanFailed('Terjadi kesalahan: $e'));
        }
      },
    );
  }
}
