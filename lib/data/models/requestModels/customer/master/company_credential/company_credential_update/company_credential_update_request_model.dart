class CompanyCredentialUpdateRequestModel {
  final String name;

  CompanyCredentialUpdateRequestModel({required this.name});

  // From JSON constructor
  factory CompanyCredentialUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    return CompanyCredentialUpdateRequestModel(
      name: json['name'],
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
