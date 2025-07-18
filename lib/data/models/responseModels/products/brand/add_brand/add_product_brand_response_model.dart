class AddProductBrandResponseModel {
  String? name;
  String? description;
  Division? division;
  String? id;
  String? createdAt;
  String? updatedAt;

  AddProductBrandResponseModel(
      {this.name,
      this.description,
      this.division,
      this.id,
      this.createdAt,
      this.updatedAt});

  AddProductBrandResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    division =
        json['division'] != null ? Division.fromJson(json['division']) : null;
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    if (division != null) {
      data['division'] = division!.toJson();
    }
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
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
  Null zohoOrganizationId;
  Null zohoTaxExemptionId;

  Division(
      {this.id,
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
      this.zohoTaxExemptionId});

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
