class RegisterDto {
  final String username;
  final String email;
  final String password;

  RegisterDto({required this.username, required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  RegisterDto copyWith({
    String? username,
    String? email,
    String? password,
  }) {
    return RegisterDto(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}