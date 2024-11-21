part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// Event untuk proses login
final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

// Event untuk proses registrasi
final class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String username;
  final String password;

  const AuthRegisterEvent({
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [email, username, password];
}

// Event untuk proses logout
final class AuthLogoutEvent extends AuthEvent {}
