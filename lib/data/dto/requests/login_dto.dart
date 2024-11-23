class LoginDto {
  final String email;
  final String password;

  LoginDto({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  LoginDto copyWith({
    String? email,
    String? password,
  }) {
    return LoginDto(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
