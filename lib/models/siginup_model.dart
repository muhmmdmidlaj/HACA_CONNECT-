class UserModel {
  String name;
  String email;
  String password;
  String confirmPassword;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  // Convert JSON to UserModel instance
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }

  // Convert UserModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
