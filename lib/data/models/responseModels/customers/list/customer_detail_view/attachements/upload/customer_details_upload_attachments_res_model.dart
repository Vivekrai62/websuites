class CustomerDetailsAttachmentsUploadResModel {
  CustomerDetailsAttachmentsUploadResModel({
    required this.customer,
    required this.type,
    required this.filename,
    required this.typeName,
    required this.uploadedBy,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final Customer? customer;
  final String? type;
  final String? filename;
  final String? typeName;
  final UploadedBy? uploadedBy;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  factory CustomerDetailsAttachmentsUploadResModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsAttachmentsUploadResModel(
      customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
      type: json["type"],
      filename: json["filename"],
      typeName: json["type_name"],
      uploadedBy: json["uploaded_by"] == null ? null : UploadedBy.fromJson(json["uploaded_by"]),
      id: json["id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
    );
  }

  static List<CustomerDetailsAttachmentsUploadResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CustomerDetailsAttachmentsUploadResModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // Added toJson method
  Map<String, dynamic> toJson() {
    return {
      'customer': customer?.toJson(),
      'type': type,
      'filename': filename,
      'type_name': typeName,
      'uploaded_by': uploadedBy?.toJson(),
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt,
    };
  }
}

class Customer {
  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.primaryEmail,
    required this.countryCode,
    required this.primaryContact,
    required this.websites,
    required this.primaryAddress,
    required this.profileImage,
    required this.dob,
    required this.gstin,
    required this.aboutClient,
    required this.otherInformation,
    required this.lat,
    required this.lng,
    required this.joinedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.deleteRemark,
    required this.zohoContactId,
    required this.status,
    required this.subStatus,
    required this.customerToCustomFields,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? primaryEmail;
  final int? countryCode;
  final String? primaryContact;
  final List<String> websites;
  final String? primaryAddress;
  final dynamic profileImage;
  final DateTime? dob;
  final String? gstin;
  final String? aboutClient;
  final String? otherInformation;
  final int? lat;
  final int? lng;
  final dynamic joinedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic deleteRemark;
  final dynamic zohoContactId;
  final String? status;
  final dynamic subStatus;
  final List<dynamic> customerToCustomFields;

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      primaryEmail: json["primary_email"],
      countryCode: json["country_code"],
      primaryContact: json["primary_contact"],
      websites: json["websites"] == null ? [] : List<String>.from(json["websites"]!.map((x) => x)),
      primaryAddress: json["primary_address"],
      profileImage: json["profile_image"],
      dob: DateTime.tryParse(json["dob"] ?? ""),
      gstin: json["gstin"],
      aboutClient: json["about_client"],
      otherInformation: json["other_information"],
      lat: json["lat"],
      lng: json["lng"],
      joinedAt: json["joined_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      deleteRemark: json["delete_remark"],
      zohoContactId: json["zoho_contact_id"],
      status: json["status"],
      subStatus: json["subStatus"],
      customerToCustomFields: json["customerToCustomFields"] == null ? [] : List<dynamic>.from(json["customerToCustomFields"]!.map((x) => x)),
    );
  }

  // Added toJson method
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
      'dob': dob?.toIso8601String(),
      'gstin': gstin,
      'about_client': aboutClient,
      'other_information': otherInformation,
      'lat': lat,
      'lng': lng,
      'joined_at': joinedAt,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt,
      'delete_remark': deleteRemark,
      'zoho_contact_id': zohoContactId,
      'status': status,
      'subStatus': subStatus,
      'customerToCustomFields': customerToCustomFields,
    };
  }
}

class UploadedBy {
  UploadedBy({
    required this.id,
  });

  final String? id;

  factory UploadedBy.fromJson(Map<String, dynamic> json) {
    return UploadedBy(
      id: json["id"],
    );
  }

  // Added toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}

