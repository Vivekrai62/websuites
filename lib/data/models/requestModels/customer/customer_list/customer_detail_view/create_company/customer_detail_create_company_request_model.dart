class CustomerViewCreateCompanyRequestModel {
  final String customer;
  final String companyName;
  final String companyEmail;
  final String companyPhone;
  final String countryCode;
  final String cCountryCode;
  final String contactPersonName;
  final String contactPersonNumber;
  final String gst;
  final String website;
  final String address;
  final String pincode;
  final String state;
  final String city;
  final String country;
  final String parent;
  final String district;
  final String stateCode;
  final String logo;
  final String addressType;

  CustomerViewCreateCompanyRequestModel({
    required this.customer,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.countryCode,
    required this.cCountryCode,
    required this.contactPersonName,
    required this.contactPersonNumber,
    required this.gst,
    required this.website,
    required this.address,
    required this.pincode,
    required this.state,
    required this.city,
    required this.country,
    required this.parent,
    required this.district,
    required this.stateCode,
    required this.logo,
    required this.addressType,
  });

  // Method to convert JSON to Model
  factory CustomerViewCreateCompanyRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerViewCreateCompanyRequestModel(
      customer: json['customer'],
      companyName: json['company_name'],
      companyEmail: json['company_email'],
      companyPhone: json['company_phone'],
      countryCode: json['country_code'],
      cCountryCode: json['c_country_code'],
      contactPersonName: json['contact_person_name'],
      contactPersonNumber: json['contact_person_number'],
      gst: json['gst'],
      website: json['website'],
      address: json['address'],
      pincode: json['pincode'],
      state: json['state'],
      city: json['city'],
      country: json['country'],
      parent: json['parent'],
      district: json['district'],
      stateCode: json['state_code'],
      logo: json['logo'],
      addressType: json['address_type'],
    );
  }

  // Method to convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'customer': customer,
      'company_name': companyName,
      'company_email': companyEmail,
      'company_phone': companyPhone,
      'country_code': countryCode,
      'c_country_code': cCountryCode,
      'contact_person_name': contactPersonName,
      'contact_person_number': contactPersonNumber,
      'gst': gst,
      'website': website,
      'address': address,
      'pincode': pincode,
      'state': state,
      'city': city,
      'country': country,
      'parent': parent,
      'district': district,
      'state_code': stateCode,
      'logo': logo,
      'address_type': addressType,
    };
  }
}
