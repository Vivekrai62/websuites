class CustToCustMergCustListResponseModel {
  String? id;
  String? companyName;
  String? companyEmail;
  String? companyPhone;
  int? countryCode;
  String? contactPersonName;
  String? contactPersonNumber;
  int? cCountryCode;
  String? address;
  String? website;
  String? gst;
  String? logo;
  int? lat;
  int? lng;
  String? pharmahopersUrl;
  City? city;
  Pincode? pincode;
  City? district;
  City? state;
  City? country;
  Customer? customer;

  CustToCustMergCustListResponseModel({
    this.id,
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
    this.pharmahopersUrl,
    this.city,
    this.pincode,
    this.district,
    this.state,
    this.country,
    this.customer,
  });

  CustToCustMergCustListResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id']?.toString();
      companyName = json['company_name']?.toString();
      companyEmail = json['company_email']?.toString();
      companyPhone = json['company_phone']?.toString();

      // Improved number parsing
      countryCode = _parseToInt(json['country_code']);
      cCountryCode = _parseToInt(json['c_country_code']);
      lat = _parseToInt(json['lat']);
      lng = _parseToInt(json['lng']);

      contactPersonName = json['contact_person_name']?.toString();
      contactPersonNumber = json['contact_person_number']?.toString();
      address = json['address']?.toString();
      website = _parseNullableString(json['website']);
      gst = json['gst']?.toString();

      // Handle logo field
      logo = _parseNullableString(json['logo']);

      // Handle pharmahopers_url field
      pharmahopersUrl = _parseNullableString(json['pharmahopers_url']);

      // Parse nested objects with null checks
      city = _parseCity(json['city']);
      pincode = _parsePincode(json['pincode']);
      district = _parseCity(json['district']);
      state = _parseCity(json['state']);
      country = _parseCity(json['country']);
      customer = _parseCustomer(json['customer']);

    } catch (e) {
      print('Error parsing CustToCustMergCustListResponseModel: $e');
      print('JSON data: $json');
      rethrow;
    }
  }

  // Helper methods for better parsing
  int? _parseToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      try {
        return int.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  String? _parseNullableString(dynamic value) {
    if (value == null || value == "null" || value == "") return null;
    return value.toString();
  }

  City? _parseCity(dynamic value) {
    if (value == null || value is! Map<String, dynamic>) return null;
    try {
      return City.fromJson(value);
    } catch (e) {
      print('Error parsing City: $e');
      return null;
    }
  }

  Pincode? _parsePincode(dynamic value) {
    if (value == null || value is! Map<String, dynamic>) return null;
    try {
      return Pincode.fromJson(value);
    } catch (e) {
      print('Error parsing Pincode: $e');
      return null;
    }
  }

  Customer? _parseCustomer(dynamic value) {
    if (value == null || value is! Map<String, dynamic>) return null;
    try {
      return Customer.fromJson(value);
    } catch (e) {
      print('Error parsing Customer: $e');
      return null;
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
    data['pharmahopers_url'] = pharmahopersUrl;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    if (pincode != null) {
      data['pincode'] = pincode!.toJson();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    if (state != null) {
      data['state'] = state!.toJson();
    }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

// City class with improved error handling
class City {
  String? id;
  String? name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id']?.toString();
      name = json['name']?.toString();
    } catch (e) {
      print('Error parsing City: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

// Pincode class with improved error handling
class Pincode {
  String? id;
  String? code;

  Pincode({this.id, this.code});

  Pincode.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id']?.toString();
      code = json['code']?.toString();
    } catch (e) {
      print('Error parsing Pincode: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    return data;
  }
}

// Customer class with improved error handling
class Customer {
  String? id;
  String? firstName;
  String? lastName;
  String? primaryEmail;
  int? countryCode;
  String? primaryContact;
  String? primaryAddress;
  String? dob;
  String? gstin;
  String? status;
  City? city;
  Pincode? pincode;
  City? district;
  City? state;
  City? country;

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.primaryEmail,
    this.countryCode,
    this.primaryContact,
    this.primaryAddress,
    this.dob,
    this.gstin,
    this.status,
    this.city,
    this.pincode,
    this.district,
    this.state,
    this.country,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id']?.toString();
      firstName = json['first_name']?.toString();
      lastName = json['last_name']?.toString();
      primaryEmail = json['primary_email']?.toString();
      countryCode = _parseToInt(json['country_code']);
      primaryContact = json['primary_contact']?.toString();
      primaryAddress = json['primary_address']?.toString();
      dob = json['dob']?.toString();
      gstin = json['gstin']?.toString();
      status = json['status']?.toString();

      city = _parseCity(json['city']);
      pincode = _parsePincode(json['pincode']);
      district = _parseCity(json['district']);
      state = _parseCity(json['state']);
      country = _parseCity(json['country']);
    } catch (e) {
      print('Error parsing Customer: $e');
      rethrow;
    }
  }

  int? _parseToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      try {
        return int.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  City? _parseCity(dynamic value) {
    if (value == null || value is! Map<String, dynamic>) return null;
    try {
      return City.fromJson(value);
    } catch (e) {
      print('Error parsing City in Customer: $e');
      return null;
    }
  }

  Pincode? _parsePincode(dynamic value) {
    if (value == null || value is! Map<String, dynamic>) return null;
    try {
      return Pincode.fromJson(value);
    } catch (e) {
      print('Error parsing Pincode in Customer: $e');
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['primary_email'] = primaryEmail;
    data['country_code'] = countryCode;
    data['primary_contact'] = primaryContact;
    data['primary_address'] = primaryAddress;
    data['dob'] = dob;
    data['gstin'] = gstin;
    data['status'] = status;
    data['city'] = city?.toJson();
    data['pincode'] = pincode?.toJson();
    data['district'] = district?.toJson();
    data['state'] = state?.toJson();
    data['country'] = country?.toJson();
    return data;
  }
}