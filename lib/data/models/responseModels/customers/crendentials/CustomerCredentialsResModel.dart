class CustomerCredentialsResModel {
  List<Item> items;
  Meta meta;

  CustomerCredentialsResModel({required this.items, required this.meta});

  factory CustomerCredentialsResModel.fromJson(Map<String, dynamic> json) {
    return CustomerCredentialsResModel(
      items: List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': List<dynamic>.from(items.map((x) => x.toJson())),
      'meta': meta.toJson(),
    };
  }
}

class Item {
  String id;
  String companyName;
  String companyEmail;
  String companyPhone;
  int countryCode;
  String contactPersonName;
  String contactPersonNumber;
  int cCountryCode;
  String address;
  dynamic website;
  dynamic gst;
  dynamic logo;
  double lat;
  double lng;
  String pharmahopersUrl;
  Customer customer;
  dynamic parent;

  Item({
    required this.id,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.countryCode,
    required this.contactPersonName,
    required this.contactPersonNumber,
    required this.cCountryCode,
    required this.address,
    this.website,
    this.gst,
    this.logo,
    required this.lat,
    required this.lng,
    required this.pharmahopersUrl,
    required this.customer,
    this.parent,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? '', // Provide a default value
      companyName: json['company_name'] ?? '', // Provide a default value
      companyEmail: json['company_email'] ?? '', // Provide a default value
      companyPhone: json['company_phone'] ?? '', // Provide a default value
      countryCode: json['country_code'] ?? 0, // Provide a default value
      contactPersonName: json['contact_person_name'] ?? '', // Provide a default value
      contactPersonNumber: json['contact_person_number'] ?? '', // Provide a default value
      cCountryCode: json['c_country_code'] ?? 0, // Provide a default value
      address: json['address'] ?? '', // Provide a default value
      website: json['website'], // Keep as is if it can be null
      gst: json['gst'], // Keep as is if it can be null
      logo: json['logo'], // Keep as is if it can be null
      lat: (json['lat'] ?? 0).toDouble(), // Provide a default value
      lng: (json['lng'] ?? 0).toDouble(), // Provide a default value
      pharmahopersUrl: json['pharmahopers_url'] ?? '', // Provide a default value
      customer: Customer.fromJson(json['customer'] ?? {}), // Handle potential null
      parent: json['parent'], // Keep as is if it can be null
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': companyName,
      'company_email': companyEmail,
      'company_phone': companyPhone,
      'country_code': countryCode,
      'contact_person_name': contactPersonName,
      'contact_person_number': contactPersonNumber,
      'c_country_code': cCountryCode,
      'address': address,
      'website': website,
      'gst': gst,
      'logo': logo,
      'lat': lat,
      'lng': lng,
      'pharmahopers_url': pharmahopersUrl,
      'customer': customer.toJson(),
      'parent': parent,
    };
  }
}

class Customer {
  String id;
  String firstName;
  String lastName;
  String primaryEmail;
  int countryCode;
  String primaryContact;
  List<dynamic> websites;
  String primaryAddress;
  dynamic profileImage;
  dynamic dob;
  dynamic gstin;
  String aboutClient;
  String otherInformation;
  double lat;
  double lng;
  dynamic joinedAt;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  dynamic deleteRemark;
  dynamic zohoContactId;
  String status;
  dynamic subStatus;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.primaryEmail,
    required this.countryCode,
    required this.primaryContact,
    required this.websites,
    required this.primaryAddress,
    this.profileImage,
    this.dob,
    this.gstin,
    required this.aboutClient,
    required this.otherInformation,
    required this.lat,
    required this.lng,
    this.joinedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.deleteRemark,
    this.zohoContactId,
    required this.status,
    this.subStatus,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? '', // Provide a default value
      firstName: json['first_name'] ?? '', // Provide a default value
      lastName: json['last_name'] ?? '', // Provide a default value
      primaryEmail: json['primary_email'] ?? '', // Provide a default value
      countryCode: json['country_code'] ?? 0, // Provide a default value
      primaryContact: json['primary_contact'] ?? '', // Provide a default value
      websites: List<dynamic>.from(json['websites'] ?? []), // Provide a default value
      primaryAddress: json['primary_address'] ?? '', // Provide a default value
      profileImage: json['profile_image'], // Keep as is if it can be null
      dob: json['dob'], // Keep as is if it can be null
      gstin: json['gstin'], // Keep as is if it can be null
      aboutClient: json['about_client'] ?? '', // Provide a default value
      otherInformation: json['other_information'] ?? '', // Provide a default value
      lat: (json['lat'] ?? 0).toDouble(), // Provide a default value
      lng: (json['lng'] ?? 0).toDouble(), // Provide a default value
      joinedAt: json['joined_at'], // Keep as is if it can be null
      createdAt: json['created_at'] ?? '', // Provide a default value
      updatedAt: json['updated_at'] ?? '', // Provide a default value
      deletedAt: json['deleted_at'], // Keep as is if it can be null
      deleteRemark: json['delete_remark'], // Keep as is if it can be null
      zohoContactId: json['zoho_contact_id'], // Keep as is if it can be null
      status: json['status'] ?? '', // Provide a default value
      subStatus: json['subStatus'], // Keep as is if it can be null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'primary_email': primaryEmail,
      'country_code': countryCode,
      'primary_contact': primaryContact,
      'websites': websites,
      'primary_address': primaryAddress,
      'profile_image': profileImage,
      'dob': dob,
      'gstin': gstin,
      'about_client': aboutClient,
      'other_information': otherInformation,
      'lat': lat,
      'lng': lng,
      'joined_at': joinedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'delete_remark': deleteRemark,
      'zoho_contact_id': zohoContactId,
      'status': status,
      'subStatus': subStatus,
    };
  }
}

class Meta {
  int currentPage;
  int itemsPerPage;
  int totalPages;
  int totalItems;
  int itemCount;

  Meta({
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemCount,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['currentPage'],
      itemsPerPage: json['itemsPerPage'],
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
      itemCount: json['itemCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'itemsPerPage': itemsPerPage,
      'totalPages': totalPages,
      'totalItems': totalItems,
      'itemCount': itemCount,
    };
  }
}
