import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:looksy_app/data/datasources/remote_datasources/auth_remote_datasources.dart';
import 'package:looksy_app/data/dto/requests/login_dto.dart';
import 'package:looksy_app/data/dto/requests/register_dto.dart';
import 'package:looksy_app/domain/entities/user.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices authServices;

  AuthBloc({required this.authServices}) : super(AuthInitial()) {
    on<AuthLoginEvent>(
      (event, emit) async {
        emit(AuthLoading());

        final response = await authServices.login(LoginDto(
          email: event.params.email,
          password: event.params.password,
        ));

        response.fold(
          (l) => emit(AuthFailed(errorMessage: l)),
          (r) => emit(AuthSuccess(user: r)),
        );
      },
    );
    on<AuthRegisterEvent>(
      (event, emit) async {
        emit(AuthLoading());

        final response = await authServices.register(RegisterDto(
          username: event.params.username,
          email: event.params.email,
          password: event.params.password,
        ));

        response.fold(
          (l) => emit(AuthFailed(errorMessage: l)),
          (r) => emit(AuthSuccess(user: r)),
        );
      },
    );
  }

  // Handler untuk logout
  Future<void> onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await authServices.logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(errorMessage: 'Error during logout: ${e.toString()}'));
    }
  }
}
