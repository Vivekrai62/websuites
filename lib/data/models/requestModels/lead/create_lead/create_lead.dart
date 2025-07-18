class CreateLeadRequestModel {
  String address;
  String addressType;
  String city;
  int countryCode;
  List<dynamic> customFields;
  String description;
  List<String> divisions;
  String email;
  String firstName;
  String gstin;
  String lastName;
  int mobile;
  String organization;
  List<String> secondaryEmails;
  List<int> secondaryMobiles;
  List<String> services;
  String source;
  String status;
  String type;
  List<String> websites;

  CreateLeadRequestModel({
    this.address = "",
    this.addressType = "indian",
    this.city = "",
    this.countryCode = 91,
    this.customFields = const [],
    this.description = "",
    required this.divisions,
    this.email = "",
    required this.firstName,
    required this.gstin,
    required this.lastName,
    required this.mobile,
    this.organization = "",
    this.secondaryEmails = const [],
    this.secondaryMobiles = const [],
    required this.services,
    required this.source,
    this.status = "in_progress",
    required this.type,
    required this.websites,
  });

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "address_type": addressType,
      "city": city,
      "country_code": countryCode,
      "custom_fields": customFields,
      "description": description,
      "divisions": divisions,
      "email": email,
      "first_name": firstName,
      "gstin": gstin,
      "last_name": lastName,
      "mobile": mobile,
      "organization": organization,
      "secondary_emails": secondaryEmails,
      "secondary_mobiles": secondaryMobiles,
      "services": services,
      "source": source,
      "status": status,
      "type": type,
      "websites": websites,
    };
  }
}
