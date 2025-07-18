class LoginRequestedModel {
  LoginRequestedModel({
    required this.password,
    required this.email,
  });

  final String password;
  final String email;

  /// Convert JSON to `LoginRequestedModel`
  factory LoginRequestedModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestedModel(
      password: json["password"] ?? '', // Ensuring it doesn't become null
      email: json["email"] ?? '',
    );
  }

  /// Convert `LoginRequestedModel` to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      "password": password,
      "email": email,
    };
  }
}
