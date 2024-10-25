class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  // Convert a Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Create a Dart object from JSON
  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json['email'],
      password: json['password'],
    );
  }
}
