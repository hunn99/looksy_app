import 'package:looksy_app/domain/entities/user.dart';

class AuthDto {
  final String? token;
  final User? user;

  AuthDto({this.token, this.user});

  factory AuthDto.fromJson(Map<String, dynamic> json) {
    return AuthDto(
      token: json['token'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}