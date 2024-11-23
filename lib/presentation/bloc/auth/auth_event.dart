part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// Event untuk proses login
final class AuthLoginEvent extends AuthEvent {
  final LoginDto params;

  const AuthLoginEvent({
    required this.params,
  });

  @override
  List<Object?> get props => [
        params.email,
        params.password,
      ];
}

// Event untuk proses registrasi
final class AuthRegisterEvent extends AuthEvent {
  final RegisterDto params;

  const AuthRegisterEvent({
    required this.params,
  });

  @override
  List<Object?> get props => [
        params.email,
        params.username,
        params.password,
      ];
}

// Event untuk proses logout
final class AuthLogoutEvent extends AuthEvent {}
