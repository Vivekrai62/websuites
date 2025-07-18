class CustomerDetailsLeadsResModel {
  CustomerDetailsLeadsResModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.mobile,
    required this.mobileWithCountrycode,
    required this.email,
    required this.organization,
    required this.description,
    required this.address,
    required this.createdAt,
    required this.divisions,
    required this.source,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final int? countryCode;
  final String? mobile;
  final String? mobileWithCountrycode;
  final String? email;
  final String? organization;
  final String? description;
  final String? address;
  final DateTime? createdAt;
  final List<Source> divisions;
  final Source? source;

  factory CustomerDetailsLeadsResModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsLeadsResModel(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      countryCode: json["country_code"],
      mobile: json["mobile"],
      mobileWithCountrycode: json["mobile_with_countrycode"],
      email: json["email"],
      organization: json["organization"],
      description: json["description"],
      address: json["address"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      divisions: json["divisions"] == null
          ? []
          : List<Source>.from(json["divisions"]!.map((x) => Source.fromJson(x))),
      source: json["source"] == null ? null : Source.fromJson(json["source"]),
    );
  }

  // Add this method to handle a list of JSON objects
  static List<CustomerDetailsLeadsResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CustomerDetailsLeadsResModel.fromJson(json))
        .toList();
  }
}

class Source {
  Source({
    required this.id,
    required this.name,
    required this.status,
  });

  final String? id;
  final String? name;
  final String? status;

  factory Source.fromJson(Map<String, dynamic> json){
    return Source(
      id: json["id"],
      name: json["name"],
      status: json["status"],
    );
  }

}
