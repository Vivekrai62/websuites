class CustomerListDetailViewListResponseModel {
  CustomerListDetailViewListResponseModel({
    required this.serviceStatus,
    required this.projectStatus,
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
    required this.customerAssigned,
    required this.customerType,
    required this.customerServices,
    required this.projects,
    required this.pincode,
    required this.district,
    required this.city,
    required this.state,
    required this.country,
    required this.customerToCustomFields,
    required this.source,
    required this.divisions,
    required this.secondaryEmails,
    required this.secondaryMobiles,
    required this.companies,
    required this.customerCredits,
    required this.isCustomerCompaniesDisabled,
  });

  final String? serviceStatus;
  final ProjectStatus? projectStatus;
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? primaryEmail;
  final int? countryCode;
  final String? primaryContact;
  final List<String> websites;
  final String? primaryAddress;
  final String? profileImage;
  final DateTime? dob;
  final String? gstin;
  final String? aboutClient;
  final String? otherInformation;
  final double? lat;
  final double? lng;
  final DateTime? joinedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? deleteRemark;
  final String? zohoContactId;
  final String? status;
  final String? subStatus;
  final List<CustomerAssigned> customerAssigned;
  final String? customerType;
  final List<String> customerServices;
  final List<Project> projects;
  final Pincode? pincode;
  final City? district;
  final City? city;
  final City? state;
  final City? country;
  final List<dynamic> customerToCustomFields;
  final City? source;
  final List<City> divisions;
  final List<SecondaryEmail> secondaryEmails;
  final List<SecondaryMobile> secondaryMobiles;
  final List<Company> companies;
  final int? customerCredits;
  final bool? isCustomerCompaniesDisabled;

  factory CustomerListDetailViewListResponseModel.fromJson(
      Map<String, dynamic> json) {
    try {
      print("=== DEBUGGING JSON PARSING ===");

      // Debug each field that could be problematic
      print(
          "serviceStatus: ${json["serviceStatus"]} (${json["serviceStatus"].runtimeType})");
      print("id: ${json["id"]} (${json["id"].runtimeType})");
      print(
          "first_name: ${json["first_name"]} (${json["first_name"].runtimeType})");
      print(
          "last_name: ${json["last_name"]} (${json["last_name"].runtimeType})");
      print(
          "primary_email: ${json["primary_email"]} (${json["primary_email"].runtimeType})");
      print(
          "primary_contact: ${json["primary_contact"]} (${json["primary_contact"].runtimeType})");
      print(
          "primary_address: ${json["primary_address"]} (${json["primary_address"].runtimeType})");
      print(
          "profile_image: ${json["profile_image"]} (${json["profile_image"].runtimeType})");
      print("gstin: ${json["gstin"]} (${json["gstin"].runtimeType})");
      print(
          "about_client: ${json["about_client"]} (${json["about_client"].runtimeType})");
      print(
          "other_information: ${json["other_information"]} (${json["other_information"].runtimeType})");
      print(
          "delete_remark: ${json["delete_remark"]} (${json["delete_remark"].runtimeType})");
      print(
          "zoho_contact_id: ${json["zoho_contact_id"]} (${json["zoho_contact_id"].runtimeType})");
      print("status: ${json["status"]} (${json["status"].runtimeType})");
      print(
          "subStatus: ${json["subStatus"]} (${json["subStatus"].runtimeType})");
      print(
          "customer_type: ${json["customer_type"]} (${json["customer_type"].runtimeType})");

      return CustomerListDetailViewListResponseModel(
        serviceStatus: _safeString(json["serviceStatus"]),
        projectStatus: json["projectStatus"] is Map<String, dynamic>
            ? ProjectStatus.fromJson(json["projectStatus"])
            : null,
        id: _safeString(json["id"]),
        firstName: _safeString(json["first_name"]),
        lastName: _safeString(json["last_name"]),
        primaryEmail: _safeString(json["primary_email"]),
        countryCode: json["country_code"],
        primaryContact: _safeString(json["primary_contact"]),
        websites: json["websites"] is List
            ? List<String>.from(
                json["websites"].map((e) => e?.toString() ?? ''))
            : <String>[],
        primaryAddress: _safeString(json["primary_address"]),
        profileImage: _safeString(json["profile_image"]),
        dob: json["dob"] != null && json["dob"].toString().isNotEmpty
            ? DateTime.tryParse(json["dob"].toString())
            : null,
        gstin: _safeString(json["gstin"]),
        aboutClient: _safeString(json["about_client"]),
        otherInformation: _safeString(json["other_information"]),
        lat: json["lat"] != null
            ? double.tryParse(json["lat"].toString())
            : null,
        lng: json["lng"] != null
            ? double.tryParse(json["lng"].toString())
            : null,
        joinedAt: json["joined_at"] != null && json["joined_at"] != ""
            ? DateTime.tryParse(json["joined_at"].toString())
            : null,
        createdAt: json["created_at"] != null && json["created_at"] != ""
            ? DateTime.tryParse(json["created_at"].toString())
            : null,
        updatedAt: json["updated_at"] != null && json["updated_at"] != ""
            ? DateTime.tryParse(json["updated_at"].toString())
            : null,
        deletedAt: json["deleted_at"] != null && json["deleted_at"] != ""
            ? DateTime.tryParse(json["deleted_at"].toString())
            : null,
        deleteRemark: _safeString(json["delete_remark"]),
        zohoContactId: _safeString(json["zoho_contact_id"]),
        status: _safeString(json["status"]),
        subStatus: _safeString(json["subStatus"]),
        customerAssigned: json["customer_assigned"] is List
            ? List<CustomerAssigned>.from(json["customer_assigned"]
                .where((x) => x != null && x is Map<String, dynamic>)
                .map((x) => CustomerAssigned.fromJson(x)))
            : <CustomerAssigned>[],
        customerType: json["customer_type"] is Map<String, dynamic>
            ? json["customer_type"]["name"]?.toString()
            : _safeString(json["customer_type"]),
        customerServices: json["customer_services"] is List
            ? List<String>.from(
                json["customer_services"].map((e) => e?.toString() ?? ''))
            : <String>[],
        projects: json["projects"] is List
            ? List<Project>.from(json["projects"]
                .where((x) => x != null && x is Map<String, dynamic>)
                .map((x) => Project.fromJson(x)))
            : <Project>[],
        pincode: json["pincode"] is Map<String, dynamic>
            ? Pincode.fromJson(json["pincode"])
            : null,
        district: json["district"] is Map<String, dynamic>
            ? City.fromJson(json["district"])
            : null,
        city: json["city"] is Map<String, dynamic>
            ? City.fromJson(json["city"])
            : null,
        state: json["state"] is Map<String, dynamic>
            ? City.fromJson(json["state"])
            : null,
        country: json["country"] is Map<String, dynamic>
            ? City.fromJson(json["country"])
            : null,
        customerToCustomFields: json["customerToCustomFields"] is List
            ? List<dynamic>.from(json["customerToCustomFields"])
            : <dynamic>[],
        source: json["source"] is Map<String, dynamic>
            ? City.fromJson(json["source"])
            : null,
        divisions: json["divisions"] is List
            ? List<City>.from(json["divisions"]
                .where((x) => x != null && x is Map<String, dynamic>)
                .map((x) => City.fromJson(x)))
            : <City>[],
        secondaryEmails: json["secondary_emails"] is List
            ? List<SecondaryEmail>.from(json["secondary_emails"]
                .where((x) => x != null && x is Map<String, dynamic>)
                .map((x) => SecondaryEmail.fromJson(x)))
            : <SecondaryEmail>[],
        secondaryMobiles: json["secondary_mobiles"] is List
            ? List<SecondaryMobile>.from(json["secondary_mobiles"]
                .where((x) => x != null && x is Map<String, dynamic>)
                .map((x) => SecondaryMobile.fromJson(x)))
            : <SecondaryMobile>[],
        companies: json["companies"] is List
            ? List<Company>.from(json["companies"]
                .where((x) => x != null && x is Map<String, dynamic>)
                .map((x) => Company.fromJson(x)))
            : <Company>[],
        customerCredits: json["customerCredits"],
        isCustomerCompaniesDisabled: json["isCustomerCompaniesDisabled"] is bool
            ? json["isCustomerCompaniesDisabled"]
            : null,
      );
    } catch (e, stackTrace) {
      print("Error in fromJson: $e");
      print("Stack trace: $stackTrace");
      print("JSON keys: ${json.keys.toList()}");
      rethrow;
    }
  }

  // Helper method to safely convert any value to String
  static String? _safeString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.isEmpty ? null : value;
    if (value is Map || value is List) {
      print(
          "WARNING: Trying to convert ${value.runtimeType} to String: $value");
      return null; // or return value.toString() if you want the string representation
    }
    return value.toString();
  }
}

class ProjectStatus {
  ProjectStatus({
    required this.inProgress,
    required this.notStarted,
  });

  final int? inProgress;
  final int? notStarted;

  factory ProjectStatus.fromJson(Map<String, dynamic> json) {
    return ProjectStatus(
      inProgress: json["In Progress"],
      notStarted: json["Not Started"],
    );
  }
}

class CustomerAssigned {
  CustomerAssigned({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  final String? id;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;

  factory CustomerAssigned.fromJson(Map<String, dynamic> json) {
    try {
      return CustomerAssigned(
        id: CustomerListDetailViewListResponseModel._safeString(json["id"]),
        status: json["status"],
        createdAt: json["created_at"] != null &&
                json["created_at"].toString().isNotEmpty
            ? DateTime.tryParse(json["created_at"].toString())
            : null,
        updatedAt: json["updated_at"] != null &&
                json["updated_at"].toString().isNotEmpty
            ? DateTime.tryParse(json["updated_at"].toString())
            : null,
        user: json["user"] is Map<String, dynamic>
            ? User.fromJson(json["user"])
            : null,
      );
    } catch (e) {
      print("Error in CustomerAssigned.fromJson: $e");
      print("JSON: $json");
      rethrow;
    }
  }
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.address,
    required this.bio,
    required this.profilePic,
    required this.password,
    required this.status,
    required this.rememberToken,
    required this.rememberTokenTime,
    required this.userDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceId,
    required this.tracking,
    required this.crmCategory,
    required this.mobileApp,
    required this.superSettings,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;
  final dynamic address;
  final dynamic bio;
  final dynamic profilePic;
  final String? password;
  final bool? status;
  final dynamic rememberToken;
  final dynamic rememberTokenTime;
  final bool? userDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deviceId;
  final bool? tracking;
  final String? crmCategory;
  final bool? mobileApp;
  final bool? superSettings;

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: CustomerListDetailViewListResponseModel._safeString(json["id"]),
        firstName: CustomerListDetailViewListResponseModel._safeString(
            json["first_name"]),
        lastName: CustomerListDetailViewListResponseModel._safeString(
            json["last_name"]),
        email:
            CustomerListDetailViewListResponseModel._safeString(json["email"]),
        mobile:
            CustomerListDetailViewListResponseModel._safeString(json["mobile"]),
        address: json["address"],
        bio: json["bio"],
        profilePic: json["profile_pic"],
        password: CustomerListDetailViewListResponseModel._safeString(
            json["password"]),
        status: json["status"],
        rememberToken: json["remember_token"],
        rememberTokenTime: json["remember_token_time"],
        userDefault: json["default"],
        createdAt: json["created_at"] != null &&
                json["created_at"].toString().isNotEmpty
            ? DateTime.tryParse(json["created_at"].toString())
            : null,
        updatedAt: json["updated_at"] != null &&
                json["updated_at"].toString().isNotEmpty
            ? DateTime.tryParse(json["updated_at"].toString())
            : null,
        deviceId: json["device_id"],
        tracking: json["tracking"],
        crmCategory: CustomerListDetailViewListResponseModel._safeString(
            json["crm_category"]),
        mobileApp: json["mobile_app"],
        superSettings: json["superSettings"],
      );
    } catch (e) {
      print("Error in User.fromJson: $e");
      print("JSON: $json");
      rethrow;
    }
  }
}

class Project {
  Project({
    required this.id,
    required this.status,
  });

  final String? id;
  final String? status;

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: CustomerListDetailViewListResponseModel._safeString(json["id"]),
      status:
          CustomerListDetailViewListResponseModel._safeString(json["status"]),
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

  factory Pincode.fromJson(Map<String, dynamic> json) {
    return Pincode(
      id: CustomerListDetailViewListResponseModel._safeString(json["id"]),
      code: CustomerListDetailViewListResponseModel._safeString(json["code"]),
    );
  }
}

class City {
  City({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: CustomerListDetailViewListResponseModel._safeString(json["id"]),
      name: CustomerListDetailViewListResponseModel._safeString(json["name"]),
    );
  }
}

class Company {
  Company({
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
    required this.pharmahopersUrl,
    required this.city,
    required this.pincode,
    required this.district,
    required this.state,
    required this.country,
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
  final String? website;
  final String? gst;
  final dynamic logo;
  final double? lat;
  final double? lng;
  final dynamic pharmahopersUrl;
  final City? city;
  final Pincode? pincode;
  final City? district;
  final City? state;
  final City? country;

  factory Company.fromJson(Map<String, dynamic> json) {
    try {
      return Company(
        id: CustomerListDetailViewListResponseModel._safeString(json["id"]),
        companyName: CustomerListDetailViewListResponseModel._safeString(
            json["company_name"]),
        companyEmail: CustomerListDetailViewListResponseModel._safeString(
            json["company_email"]),
        companyPhone: CustomerListDetailViewListResponseModel._safeString(
            json["company_phone"]),
        countryCode: json["country_code"],
        contactPersonName: CustomerListDetailViewListResponseModel._safeString(
            json["contact_person_name"]),
        contactPersonNumber:
            CustomerListDetailViewListResponseModel._safeString(
                json["contact_person_number"]),
        cCountryCode: json["c_country_code"],
        address: CustomerListDetailViewListResponseModel._safeString(
            json["address"]),
        website: CustomerListDetailViewListResponseModel._safeString(
            json["website"]),
        gst: CustomerListDetailViewListResponseModel._safeString(json["gst"]),
        logo: json["logo"],
        lat: json["lat"] != null
            ? double.tryParse(json["lat"].toString())
            : null,
        lng: json["lng"] != null
            ? double.tryParse(json["lng"].toString())
            : null,
        pharmahopersUrl: json["pharmahopers_url"],
        city: json["city"] is Map<String, dynamic>
            ? City.fromJson(json["city"])
            : null,
        pincode: json["pincode"] is Map<String, dynamic>
            ? Pincode.fromJson(json["pincode"])
            : null,
        district: json["district"] is Map<String, dynamic>
            ? City.fromJson(json["district"])
            : null,
        state: json["state"] is Map<String, dynamic>
            ? City.fromJson(json["state"])
            : null,
        country: json["country"] is Map<String, dynamic>
            ? City.fromJson(json["country"])
            : null,
      );
    } catch (e) {
      print("Error in Company.fromJson: $e");
      print("JSON: $json");
      rethrow;
    }
  }
}

class SecondaryEmail {
  final String? id;
  final String? email;
  final String? createdAt;
  final String? updatedAt;

  SecondaryEmail({
    this.id,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory SecondaryEmail.fromJson(Map<String, dynamic> json) {
    return SecondaryEmail(
      id: json['id']?.toString(),
      email: json['email']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}

class SecondaryMobile {
  final String? id;
  final String? mobile;
  final String? countryCode;
  final String? mobileWithCountryCode;
  final String? createdAt;
  final String? updatedAt;

  SecondaryMobile({
    this.id,
    this.mobile,
    this.countryCode,
    this.mobileWithCountryCode,
    this.createdAt,
    this.updatedAt,
  });

  factory SecondaryMobile.fromJson(Map<String, dynamic> json) {
    return SecondaryMobile(
      id: json['id']?.toString(),
      mobile: json['mobile']?.toString(),
      countryCode: json['country_code']?.toString(),
      mobileWithCountryCode: json['mobile_with_countrycode']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}
