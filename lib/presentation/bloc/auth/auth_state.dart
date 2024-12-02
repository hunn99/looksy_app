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

  AuthSuccess copyWith({User? user}) {
    return AuthSuccess(
      user: user ??
          this.user, // Gunakan user baru jika tersedia, jika tidak, gunakan yang lama
    );
  }

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

// State ketika pengguna berhasil logout
final class AuthLoggedOut extends AuthState {
  const AuthLoggedOut();

  @override
  List<Object?> get props => [];
}

// State ketika data profil pengguna berhasil diambil
final class AuthUserLoaded extends AuthState {
  final User user;

  const AuthUserLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

// State ketika terjadi kesalahan saat mengambil data profil pengguna
final class AuthUserLoadFailed extends AuthState {
  final String errorMessage;

  const AuthUserLoadFailed({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// State ketika profil pengguna berhasil diperbarui
final class AuthProfileUpdated extends AuthState {
  final User user;

  const AuthProfileUpdated({required this.user});

  @override
  List<Object?> get props => [user];
}
