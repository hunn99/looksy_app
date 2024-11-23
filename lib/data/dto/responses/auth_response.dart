class AuthResponse {
  final String? token;

  AuthResponse({this.token});
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    // get data from json["data"]
    final data = json["data"];

    if (data != null) {
      // if data is not null, get token from data
      return AuthResponse(
        token: data["token"],
      );
    } else {
      return AuthResponse(
        token: null,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "data": {
          "token": token,
        },
      };
}
