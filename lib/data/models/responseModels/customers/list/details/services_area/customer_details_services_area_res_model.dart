class CustomerDetailsServiceAreaResModel {
  CustomerDetailsServiceAreaResModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.company,
    required this.division,
    required this.brand,
    required this.product,
    required this.pincode,
    required this.district,
    required this.state,
    required this.createdBy,
  });

  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Company? company;
  final District? division;
  final dynamic brand;
  final District? product;
  final Pincode? pincode;
  final District? district;
  final District? state;
  final CreatedBy? createdBy;

  factory CustomerDetailsServiceAreaResModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsServiceAreaResModel(
      id: json["id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      company: json["company"] == null ? null : Company.fromJson(json["company"]),
      division: json["division"] == null ? null : District.fromJson(json["division"]),
      brand: json["brand"],
      product: json["product"] == null ? null : District.fromJson(json["product"]),
      pincode: json["pincode"] == null ? null : Pincode.fromJson(json["pincode"]),
      district: json["district"] == null ? null : District.fromJson(json["district"]),
      state: json["state"] == null ? null : District.fromJson(json["state"]),
      createdBy: json["createdBy"] == null ? null : CreatedBy.fromJson(json["createdBy"]),
    );
  }

  // Add this method to handle JSON list
  static List<CustomerDetailsServiceAreaResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerDetailsServiceAreaResModel.fromJson(json)).toList();
  }
}

class Company {
  Company({
    required this.id,
    required this.companyName,
  });

  final String? id;
  final String? companyName;

  factory Company.fromJson(Map<String, dynamic> json){
    return Company(
      id: json["id"],
      companyName: json["company_name"],
    );
  }

}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final String? id;
  final String? firstName;
  final String? lastName;

  factory CreatedBy.fromJson(Map<String, dynamic> json){
    return CreatedBy(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
    );
  }

}

class District {
  District({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory District.fromJson(Map<String, dynamic> json){
    return District(
      id: json["id"],
      name: json["name"],
    );
  }

}

class Pincode {
  Pincode({
    required this.id,
    required this.code,
  });

  final String? id;
  final String? code;

  factory Pincode.fromJson(Map<String, dynamic> json){
    return Pincode(
      id: json["id"],
      code: json["code"],
    );
  }

}
