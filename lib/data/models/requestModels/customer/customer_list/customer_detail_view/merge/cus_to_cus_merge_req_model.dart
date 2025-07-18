class CustomerToCustomerMergeReqModel {
  final String primaryCustomer;
  final String secondaryCustomer;
  final String firstName;
  final String? lastName;
  final String primaryEmail;
  final List<String>? secondaryEmails;
  final String primaryContact;
  final String? countryCode;
  final List<SecondaryMobile>? secondaryMobiles;
  final String? dob;
  final List<String>? divisions;
  final List<String>? websites;
  final String? gstin;
  final String? otherInformation;
  final String? primaryAddress;
  final String? pincode;
  final String? city;
  final String? district;
  final String? state;
  final String? country;
  final List<String>? assignees; // Add this field

  CustomerToCustomerMergeReqModel({
    required this.primaryCustomer,
    required this.secondaryCustomer,
    required this.firstName,
    this.lastName,
    required this.primaryEmail,
    this.secondaryEmails,
    required this.primaryContact,
    this.countryCode,
    this.secondaryMobiles,
    this.dob,
    this.divisions,
    this.websites,
    this.gstin,
    this.otherInformation,
    this.primaryAddress,
    this.pincode,
    this.city,
    this.district,
    this.state,
    this.country,
    this.assignees, // Initialize the field
  });

  Map<String, dynamic> toJson() {
    return {
      'primary_customer': primaryCustomer, // Changed to snake_case
      'secondary_customer': secondaryCustomer, // Changed to snake_case
      'first_name': firstName,
      'last_name': lastName,
      'primary_email': primaryEmail,
      'secondary_emails': secondaryEmails ?? [],
      'primary_contact': primaryContact,
      'country_code': countryCode,
      'secondary_mobiles':
          secondaryMobiles?.map((e) => e.toJson()).toList() ?? [],
      'dob': dob,
      'divisions': divisions ?? [],
      'websites': websites ?? [],
      'gstin': gstin,
      'other_information': otherInformation,
      'primary_address': primaryAddress,
      'pincode': pincode,
      'city': city,
      'district': district,
      'state': state,
      'country': country,
      'assignees': assignees ?? [],
    };
  }
}

class SecondaryMobile {
  final String? countryCode;
  final String? mobile;

  SecondaryMobile({this.countryCode, this.mobile});

  Map<String, dynamic> toJson() {
    return {
      'country_code': countryCode,
      'mobile': mobile,
    };
  }
}
