class CustomerToCustomerMergeResModel {
  CustomerToCustomerMergeResModel({
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
    required this.divisions,
    required this.source,
    required this.customerAssigned,
    required this.country,
    required this.customerType,
    required this.customerLogin,
    required this.createdBy,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? primaryEmail;
  final int? countryCode;
  final int? primaryContact;
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
  final List<Division> divisions;
  final Source? source;
  final List<dynamic> customerAssigned;
  final Country? country;
  final CustomerType? customerType;
  final CustomerLogin? customerLogin;
  final CreatedBy? createdBy;

  factory CustomerToCustomerMergeResModel.fromJson(Map<String, dynamic> json) {
    return CustomerToCustomerMergeResModel(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      primaryEmail: json["primary_email"],
      countryCode: json["country_code"],
      primaryContact: json["primary_contact"],
      websites: json["websites"] == null
          ? []
          : List<String>.from(json["websites"]!.map((x) => x)),
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
      divisions: json["divisions"] == null
          ? []
          : List<Division>.from(
              json["divisions"]!.map((x) => Division.fromJson(x))),
      source: json["source"] == null ? null : Source.fromJson(json["source"]),
      customerAssigned: json["customer_assigned"] == null
          ? []
          : List<dynamic>.from(json["customer_assigned"]!.map((x) => x)),
      country:
          json["country"] == null ? null : Country.fromJson(json["country"]),
      customerType: json["customer_type"] == null
          ? null
          : CustomerType.fromJson(json["customer_type"]),
      customerLogin: json["customerLogin"] == null
          ? null
          : CustomerLogin.fromJson(json["customerLogin"]),
      createdBy: json["created_by"] == null
          ? null
          : CreatedBy.fromJson(json["created_by"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'primaryEmail': primaryEmail,
      'countryCode': countryCode,
      'primaryContact': primaryContact,
      'websites': websites,
      'primaryAddress': primaryAddress,
      'profileImage': profileImage,
      'dob': dob?.toIso8601String(),
      'gstin': gstin,
      'aboutClient': aboutClient,
      'otherInformation': otherInformation,
      'lat': lat,
      'lng': lng,
      'joinedAt': joinedAt,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt,
      'deleteRemark': deleteRemark,
      'zohoContactId': zohoContactId,
      'status': status,
      'subStatus': subStatus,
      'divisions': divisions.map((d) => d.toJson()).toList(),
      'source': source?.toJson(),
      'customerAssigned': customerAssigned,
      'country': country?.toJson(),
      'customerType': customerType?.toJson(),
      'customerLogin': customerLogin?.toJson(),
      'createdBy': createdBy?.toJson(),
    };
  }

  @override
  String toString() => toJson().toString();
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
    required this.isDefault,
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
  final bool? isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Country.fromJson(Map<String, dynamic> json) {
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
      isDefault: json["is_default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
      'native': native,
      'phone': phone,
      'continent': continent,
      'capital': capital,
      'currency': currency,
      'status': status,
      'installStatus': installStatus,
      'isDefault': isDefault,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.customers,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final List<Customer> customers;

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      customers: json["customers"] == null
          ? []
          : List<Customer>.from(
              json["customers"]!.map((x) => Customer.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'customers': customers.map((c) => c.toJson()).toList(),
    };
  }
}

class Customer {
  Customer({
    required this.id,
  });

  final String? id;

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}

class CustomerLogin {
  CustomerLogin({
    required this.id,
    required this.customer,
  });

  final String? id;
  final Customer? customer;

  factory CustomerLogin.fromJson(Map<String, dynamic> json) {
    return CustomerLogin(
      id: json["id"],
      customer:
          json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer?.toJson(),
    };
  }
}

class CustomerType {
  CustomerType({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CustomerType.fromJson(Map<String, dynamic> json) {
    return CustomerType(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class Division {
  Division({
    required this.id,
    required this.name,
    required this.status,
    required this.mobileNo,
    required this.contactPerson,
    required this.email,
    required this.address,
    required this.logo,
    required this.termConditions,
    required this.gstin,
    required this.createdAt,
    required this.updatedAt,
    required this.zohoOrganizationId,
    required this.zohoTaxExemptionId,
  });

  final String? id;
  final String? name;
  final String? status;
  final String? mobileNo;
  final String? contactPerson;
  final String? email;
  final String? address;
  final dynamic logo;
  final String? termConditions;
  final String? gstin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic zohoOrganizationId;
  final dynamic zohoTaxExemptionId;

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      mobileNo: json["mobile_no"],
      contactPerson: json["contact_person"],
      email: json["email"],
      address: json["address"],
      logo: json["logo"],
      termConditions: json["term_conditions"],
      gstin: json["gstin"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      zohoOrganizationId: json["zoho_organization_id"],
      zohoTaxExemptionId: json["zoho_tax_exemption_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'mobileNo': mobileNo,
      'contactPerson': contactPerson,
      'email': email,
      'address': address,
      'logo': logo,
      'termConditions': termConditions,
      'gstin': gstin,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'zohoOrganizationId': zohoOrganizationId,
      'zohoTaxExemptionId': zohoTaxExemptionId,
    };
  }
}

class Source {
  Source({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updateAt,
  });

  final String? id;
  final String? name;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updateAt;

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updateAt: DateTime.tryParse(json["update_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updateAt': updateAt?.toIso8601String(),
    };
  }
}
