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
final class AuthLoading extends AuthState {
  final bool isLoading;

  const AuthLoading({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

// State ketika registrasi atau login berhasil
final class AuthSuccess extends AuthState {
  final String token;
  final String username;

  const AuthSuccess({required this.token, required this.username});

  @override
  List<Object?> get props => [token, username];
}

// State ketika registrasi atau login gagal
final class AuthFailed extends AuthState {
  final String errorMessage;

  const AuthFailed({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// State khusus untuk logout (opsional jika diperlukan)
final class AuthLogout extends AuthState {}
