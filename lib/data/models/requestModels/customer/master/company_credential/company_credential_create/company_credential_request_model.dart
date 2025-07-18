class CompanyCredentialCreateRequestModel{
  String name;

  CompanyCredentialCreateRequestModel({required this.name});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
