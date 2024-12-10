part of 'scan_bloc.dart';

sealed class ScanState extends Equatable {
  const ScanState();

  @override
  List<Object?> get props => [];
}

class ScanInitial extends ScanState {}

class ScanLoading extends ScanState {}

class ScanSuccess extends ScanState {
  final List<HairStyle> hairstyles;
  const ScanSuccess({required this.hairstyles});

  @override
  List<Object?> get props => [hairstyles];
}

class ScanFailed extends ScanState {
  final String errorMessage;

  const ScanFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
