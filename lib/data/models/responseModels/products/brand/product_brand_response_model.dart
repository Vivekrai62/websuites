class ProductBrandResponseModel {
  String? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  Division? division;

  ProductBrandResponseModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.division,
  });

  ProductBrandResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    division =
        json['division'] != null ? Division.fromJson(json['division']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (division != null) {
      data['division'] = division!.toJson();
    }
    return data;
  }

  static List<ProductBrandResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductBrandResponseModel.fromJson(json))
        .toList();
  }
}

class Division {
  String? id;
  String? name;
  String? status;
  String? mobileNo;
  String? contactPerson;
  String? email;
  String? address;
  String? logo;
  String? createdAt;
  String? updatedAt;
  dynamic zohoOrganizationId;
  dynamic zohoTaxExemptionId;

  Division({
    this.id,
    this.name,
    this.status,
    this.mobileNo,
    this.contactPerson,
    this.email,
    this.address,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.zohoOrganizationId,
    this.zohoTaxExemptionId,
  });

  Division.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    mobileNo = json['mobile_no'];
    contactPerson = json['contact_person'];
    email = json['email'];
    address = json['address'];
    logo = json['logo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    zohoOrganizationId = json['zoho_organization_id'];
    zohoTaxExemptionId = json['zoho_tax_exemption_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['mobile_no'] = mobileNo;
    data['contact_person'] = contactPerson;
    data['email'] = email;
    data['address'] = address;
    data['logo'] = logo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['zoho_organization_id'] = zohoOrganizationId;
    data['zoho_tax_exemption_id'] = zohoTaxExemptionId;
    return data;
  }
}
