class User {
  final int id;
  final String username;
  final String email;
  final String? profileImage; // URL gambar profil

  User({
    required this.id,
    required this.username,
    required this.email,
    this.profileImage,
  });

  // Factory method to create an instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      profileImage: json['profile_image'] as String?, // Pastikan backend mengirim URL gambar
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'profile_image': profileImage,
    };
  }
}
