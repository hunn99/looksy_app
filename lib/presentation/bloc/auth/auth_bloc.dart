import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:looksy_app/data/datasources/remote_datasources/auth_remote_datasources.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices authServices;

  AuthBloc({required this.authServices}) : super(AuthInitial()) {
    on<AuthLoginEvent>(_onLogin);
    on<AuthRegisterEvent>(_onRegister);
    on<AuthLogoutEvent>(_onLogout);
  }

  // Handler untuk login
  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading(isLoading: true));

    try {
      final success = await authServices.login(
        email: event.email,
        password: event.password,
      );

      if (success) {
        final prefs = await SharedPreferences.getInstance();
        final username = prefs.getString('username') ?? '';
        emit(AuthSuccess(token: prefs.getString('auth_token') ?? '', username: username));
      } else {
        emit(const AuthFailed(errorMessage: 'Login failed. Invalid credentials.'));
      }
    } catch (e) {
      emit(AuthFailed(errorMessage: 'Error during login: ${e.toString()}'));
    } finally {
      emit(const AuthLoading(isLoading: false));
    }
  }

  // Handler untuk register
  Future<void> _onRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading(isLoading: true));

    try {
      await authServices.signUp(
        email: event.email,
        username: event.username,
        password: event.password,
      );

      emit(AuthSuccess(token: 'dummy_token', username: event.username));
    } catch (e) {
      emit(AuthFailed(errorMessage: 'Error during registration: ${e.toString()}'));
    } finally {
      emit(const AuthLoading(isLoading: false));
    }
  }

  // Handler untuk logout
  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await authServices.logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(errorMessage: 'Error during logout: ${e.toString()}'));
    }
  }
}
