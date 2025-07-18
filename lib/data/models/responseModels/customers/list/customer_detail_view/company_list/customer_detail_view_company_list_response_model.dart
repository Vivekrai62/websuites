class CustomerDetailViewCompanyListResponseModel {
  String? id;
  String? companyName;
  String? companyEmail;
  String? companyPhone;
  int? countryCode;
  String? contactPersonName;
  String? contactPersonNumber;
  int? cCountryCode;
  String? address;
  Null website;
  Null gst;
  Null logo;
  int? lat;
  int? lng;
  Pincode? pincode;
  District? district;
  City? city;
  State? state;
  Country? country;
  List<Null>? children;

  CustomerDetailViewCompanyListResponseModel(
      {this.id,
      this.companyName,
      this.companyEmail,
      this.companyPhone,
      this.countryCode,
      this.contactPersonName,
      this.contactPersonNumber,
      this.cCountryCode,
      this.address,
      this.website,
      this.gst,
      this.logo,
      this.lat,
      this.lng,
      this.pincode,
      this.district,
      this.city,
      this.state,
      this.country,
      this.children});

  CustomerDetailViewCompanyListResponseModel.fromJson(
      Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    countryCode = json['country_code'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    cCountryCode = json['c_country_code'];
    address = json['address'];
    website = json['website'];
    gst = json['gst'];
    logo = json['logo'];
    lat = json['lat'];
    lng = json['lng'];
    pincode =
        json['pincode'] != null ? Pincode.fromJson(json['pincode']) : null;
    district =
        json['district'] != null ? District.fromJson(json['district']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    state = json['state'] != null ? State.fromJson(json['state']) : null;
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    if (json['children'] != null) {
      children = <Null>[];
      json['children'].forEach((v) {
        children!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    data['company_email'] = companyEmail;
    data['company_phone'] = companyPhone;
    data['country_code'] = countryCode;
    data['contact_person_name'] = contactPersonName;
    data['contact_person_number'] = contactPersonNumber;
    data['c_country_code'] = cCountryCode;
    data['address'] = address;
    data['website'] = website;
    data['gst'] = gst;
    data['logo'] = logo;
    data['lat'] = lat;
    data['lng'] = lng;
    if (pincode != null) {
      data['pincode'] = pincode!.toJson();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    if (state != null) {
      data['state'] = state!.toJson();
    }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (children != null) {
      data['children'] = children!.map((v) => ()).toList();
    }
    return data;
  }

  static List<CustomerDetailViewCompanyListResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map(
            (json) => CustomerDetailViewCompanyListResponseModel.fromJson(json))
        .toList();
  }
}

class Pincode {
  String? id;
  String? code;
  Null lat;
  Null lng;
  String? createdAt;
  String? updatedAt;

  Pincode(
      {this.id, this.code, this.lat, this.lng, this.createdAt, this.updatedAt});

  Pincode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['lat'] = lat;
    data['lng'] = lng;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class District {
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  District({this.id, this.name, this.createdAt, this.updatedAt});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class City {
  String? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;

  City({this.id, this.name, this.status, this.createdAt, this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class State {
  String? id;
  String? name;
  String? code;
  String? status;
  String? createdAt;
  String? updatedAt;

  State(
      {this.id,
      this.name,
      this.code,
      this.status,
      this.createdAt,
      this.updatedAt});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Country {
  String? id;
  String? name;
  String? shortName;
  String? native;
  String? phone;
  String? continent;
  String? capital;
  String? currency;
  String? status;
  bool? installStatus;
  String? createdAt;
  String? updatedAt;

  Country(
      {this.id,
      this.name,
      this.shortName,
      this.native,
      this.phone,
      this.continent,
      this.capital,
      this.currency,
      this.status,
      this.installStatus,
      this.createdAt,
      this.updatedAt});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    native = json['native'];
    phone = json['phone'];
    continent = json['continent'];
    capital = json['capital'];
    currency = json['currency'];
    status = json['status'];
    installStatus = json['installStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['shortName'] = shortName;
    data['native'] = native;
    data['phone'] = phone;
    data['continent'] = continent;
    data['capital'] = capital;
    data['currency'] = currency;
    data['status'] = status;
    data['installStatus'] = installStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
