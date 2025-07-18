class CreateLeadsResponseModel {
  String? id;
  Null firstName;
  Null lastName;
  int? countryCode;
  String? mobile;
  String? mobileWithCountryCode;
  Null email;
  Null organization;
  Null description;
  Null address;
  Null city;
  Null state;
  Null deadRemark;
  String? createdAt;
  String? updatedAt;
  String? latestEnquiryDate;
  String? leadStatus;
  Null type;
  Null subType;
  List<Enquiries>? enquiries;
  List<LeadAssigned>? leadAssigned;
  Null lastReminder;
  Null lastActivity;
  Null pincode;
  Null leadCity;
  Null leadState;
  Null leadCountry;
  Source? source;

  CreateLeadsResponseModel(
      {this.id,
        this.firstName,
        this.lastName,
        this.countryCode,
        this.mobile,
        this.mobileWithCountryCode,
        this.email,
        this.organization,
        this.description,
        this.address,
        this.city,
        this.state,
        this.deadRemark,
        this.createdAt,
        this.updatedAt,
        this.latestEnquiryDate,
        this.leadStatus,
        this.type,
        this.subType,
        this.enquiries,
        this.leadAssigned,
        this.lastReminder,
        this.lastActivity,
        this.pincode,
        this.leadCity,
        this.leadState,
        this.leadCountry,
        this.source});

  CreateLeadsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    mobileWithCountryCode = json['mobile_with_countryside'];
    email = json['email'];
    organization = json['organization'];
    description = json['description'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    deadRemark = json['dead_remark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    latestEnquiryDate = json['latest_enquiry_date'];
    leadStatus = json['leadStatus'];
    type = json['type'];
    subType = json['sub_type'];
    if (json['enquiries'] != null) {
      enquiries = <Enquiries>[];
      json['enquiries'].forEach((v) {
        enquiries!.add(Enquiries.fromJson(v));
      });
    }
    if (json['lead_assigned'] != null) {
      leadAssigned = <LeadAssigned>[];
      json['lead_assigned'].forEach((v) {
        leadAssigned!.add(LeadAssigned.fromJson(v));
      });
    }
    lastReminder = json['last_reminder'];
    lastActivity = json['last_activity'];
    pincode = json['pincode'];
    leadCity = json['lead_city'];
    leadState = json['lead_state'];
    leadCountry = json['lead_country'];
    source =
    json['source'] != null ? Source.fromJson(json['source']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['mobile_with_countryside'] = mobileWithCountryCode;
    data['email'] = email;
    data['organization'] = organization;
    data['description'] = description;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['dead_remark'] = deadRemark;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['latest_enquiry_date'] = latestEnquiryDate;
    data['leadStatus'] = leadStatus;
    data['type'] = type;
    data['sub_type'] = subType;
    if (enquiries != null) {
      data['enquiries'] = enquiries!.map((v) => v.toJson()).toList();
    }
    if (leadAssigned != null) {
      data['lead_assigned'] =
          leadAssigned!.map((v) => v.toJson()).toList();
    }
    data['last_reminder'] = lastReminder;
    data['last_activity'] = lastActivity;
    data['pincode'] = pincode;
    data['lead_city'] = leadCity;
    data['lead_state'] = leadState;
    data['lead_country'] = leadCountry;
    if (source != null) {
      data['source'] = source!.toJson();
    }
    return data;
  }
}

class Enquiries {
  String? id;

  Enquiries({this.id});

  Enquiries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class LeadAssigned {
  String? id;
  User? user;

  LeadAssigned({this.id, this.user});

  LeadAssigned.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;

  User({this.id, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}