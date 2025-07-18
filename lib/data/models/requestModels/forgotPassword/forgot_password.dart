class ForgotPasswordRequestedModel {
  String? email;
  ForgotPasswordRequestedModel({
    this.email,
  });

  // Factory constructor to update a User from a JSON map
  factory ForgotPasswordRequestedModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordRequestedModel(
      email: json['email'],

    );
  }

  // Method to convert a User instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

