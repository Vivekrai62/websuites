class CustomerViewCreateCompanyResponseModel {
  CustomerViewCreateCompanyResponseModel({
    required this.id,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.countryCode,
    required this.contactPersonName,
    required this.contactPersonNumber,
    required this.cCountryCode,
    required this.address,
    required this.website,
    required this.gst,
    required this.logo,
    required this.lat,
    required this.lng,
    required this.pincode,
    required this.district,
    required this.city,
    required this.state,
    required this.country,
    required this.children,
  });

  final String? id;
  final String? companyName;
  final String? companyEmail;
  final String? companyPhone;
  final int? countryCode;
  final String? contactPersonName;
  final String? contactPersonNumber;
  final int? cCountryCode;
  final String? address;
  final dynamic website;
  final String? gst;
  final dynamic logo;
  final int? lat;
  final int? lng;
  final Pincode? pincode;
  final City? district;
  final City? city;
  final City? state;
  final Country? country;
  final List<dynamic> children;

  factory CustomerViewCreateCompanyResponseModel.fromJson(Map<String, dynamic> json){
    return CustomerViewCreateCompanyResponseModel(
      id: json["id"],
      companyName: json["company_name"],
      companyEmail: json["company_email"],
      companyPhone: json["company_phone"],
      countryCode: json["country_code"],
      contactPersonName: json["contact_person_name"],
      contactPersonNumber: json["contact_person_number"],
      cCountryCode: json["c_country_code"],
      address: json["address"],
      website: json["website"],
      gst: json["gst"],
      logo: json["logo"],
      lat: json["lat"],
      lng: json["lng"],
      pincode: json["pincode"] == null ? null : Pincode.fromJson(json["pincode"]),
      district: json["district"] == null ? null : City.fromJson(json["district"]),
      city: json["city"] == null ? null : City.fromJson(json["city"]),
      state: json["state"] == null ? null : City.fromJson(json["state"]),
      country: json["country"] == null ? null : Country.fromJson(json["country"]),
      children: json["children"] == null ? [] : List<dynamic>.from(json["children"]!.map((x) => x)),
    );
  }
  static List<CustomerViewCreateCompanyResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerViewCreateCompanyResponseModel.fromJson(json)).toList();
  }

}

class City {
  City({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
  });

  final String? id;
  final String? name;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? code;

  factory City.fromJson(Map<String, dynamic> json){
    return City(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      code: json["code"],
    );
  }

}

class Country {
  Country({
    required this.id,
    required this.name,
    required this.shortName,
    required this.native,
    required this.phone,
    required this.continent,
    required this.capital,
    required this.currency,
    required this.status,
    required this.installStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? shortName;
  final String? native;
  final String? phone;
  final String? continent;
  final String? capital;
  final String? currency;
  final String? status;
  final bool? installStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Country.fromJson(Map<String, dynamic> json){
    return Country(
      id: json["id"],
      name: json["name"],
      shortName: json["shortName"],
      native: json["native"],
      phone: json["phone"],
      continent: json["continent"],
      capital: json["capital"],
      currency: json["currency"],
      status: json["status"],
      installStatus: json["installStatus"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class Pincode {
  Pincode({
    required this.id,
    required this.code,
    required this.lat,
    required this.lng,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? code;
  final dynamic lat;
  final dynamic lng;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Pincode.fromJson(Map<String, dynamic> json){
    return Pincode(
      id: json["id"],
      code: json["code"],
      lat: json["lat"],
      lng: json["lng"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
