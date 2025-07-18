// class RequestModel {
//   final String customer;
//   final String companyName;
//   final String companyEmail;
//   final String companyPhone;
//   final String countryCode;
//   final String cCountryCode;
//   final String contactPersonName;
//   final String contactPersonNumber;
//   final String address;
//   final String pincode;
//   final String state;
//   final String city;
//   final String country;
//   final String district;
//   final String parent;
//   final String stateCode;
//   final String addressType;
//
//   RequestModel({
//     required this.customer,
//     required this.companyName,
//     required this.companyEmail,
//     required this.companyPhone,
//     required this.countryCode,
//     required this.cCountryCode,
//     required this.contactPersonName,
//     required this.contactPersonNumber,
//     required this.address,
//     required this.pincode,
//     required this.state,
//     required this.city,
//     required this.country,
//     required this.district,
//     required this.parent,
//     required this.stateCode,
//     required this.addressType,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       "customer": customer,
//       "company_name": companyName,
//       "company_email": companyEmail,
//       "company_phone": companyPhone,
//       "country_code": countryCode,
//       "c_country_code": cCountryCode,
//       "contact_person_name": contactPersonName,
//       "contact_person_number": contactPersonNumber,
//       "address": address,
//       "pincode": pincode,
//       "state": state,
//       "city": city,
//       "country": country,
//       "district": district,
//       "parent": parent,
//       "state_code": stateCode,
//       "address_type": addressType,
//     };
//   }
//
//   factory RequestModel.fromJson(Map<String, dynamic> json) {
//     return RequestModel(
//       customer: json['customer'],
//       companyName: json['company_name'],
//       companyEmail: json['company_email'],
//       companyPhone: json['company_phone'],
//       countryCode: json['country_code'],
//       cCountryCode: json['c_country_code'],
//       contactPersonName: json['contact_person_name'],
//       contactPersonNumber: json['contact_person_number'],
//       address: json['address'],
//       pincode: json['pincode'],
//       state: json['state'],
//       city: json['city'],
//       country: json['country'],
//       district: json['district'],
//       parent: json['parent'],
//       stateCode: json['state_code'],
//       addressType: json['address_type'],
//     );
//   }
// }



class CustomerRequestModel {
  final String customer;
  final String companyName;
  final String companyEmail;
  final String companyPhone;
  final String countryCode;
  final String contactPersonName;
  final String contactPersonNumber;
  final String gst;
  final String website;
  final String address;
  final String pincode;
  final String state;
  final String city;
  final String country;
  final String district;
  CustomerRequestModel({
    required this.customer,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.countryCode,
    required this.contactPersonName,
    required this.contactPersonNumber,
    required this.gst,
    required this.website,
    required this.address,
    required this.pincode,
    required this.state,
    required this.city,
    required this.country,
    required this.district,

  });

  // To JSON conversion
  Map<String, dynamic> toJson() {
    return {
      "customer": customer,
      "company_name": companyName,
      "company_email": companyEmail,
      "company_phone": companyPhone,
      "country_code": countryCode,
      "contact_person_name": contactPersonName,
      "contact_person_number": contactPersonNumber,
      "gst": gst,
      "website": website,
      "address": address,
      "pincode": pincode,
      "state": state,
      "city": city,
      "country": country,
      "district": district,
    };
  }

  // From JSON conversion
  factory CustomerRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerRequestModel(
      customer: json['customer'],
      companyName: json['company_name'],
      companyEmail: json['company_email'],
      companyPhone: json['company_phone'],
      countryCode: json['country_code'],
      contactPersonName: json['contact_person_name'],
      contactPersonNumber: json['contact_person_number'],
      gst: json['gst'],
      website: json['website'],
      address: json['address'],
      pincode: json['pincode'],
      state: json['state'],
      city: json['city'],
      country: json['country'],
      district: json['district'],

    );
  }
}


