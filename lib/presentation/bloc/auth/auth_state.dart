part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// State awal ketika proses otentikasi belum dimulai
final class AuthInitial extends AuthState {}

// State ketika proses otentikasi sedang berlangsung (loading)
final class AuthLoading extends AuthState {}

// State ketika registrasi atau login berhasil
final class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

// State ketika registrasi atau login gagal
final class AuthFailed extends AuthState {
  final String errorMessage;

  const AuthFailed({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// State khusus untuk logout (opsional jika diperlukan)
final class AuthLogout extends AuthState {
  const AuthLogout();

  @override
  List<Object?> get props => [];
}
