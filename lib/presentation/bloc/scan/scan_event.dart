part of 'scan_bloc.dart';

class ScanEvent extends Equatable {
  const ScanEvent();

  @override
  List<Object?> get props => [];
}

final class UploadImageEvent extends ScanEvent {
  final File imageFile;

  const UploadImageEvent(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}
