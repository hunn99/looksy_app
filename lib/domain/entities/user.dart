class User {
  final int id;
  final String username;
  final String email;
  final String? photo;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.photo,
  });

  // Factory method to create an instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      photo: json['photo'] as String?,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'photo': photo,
    };
  }
}
