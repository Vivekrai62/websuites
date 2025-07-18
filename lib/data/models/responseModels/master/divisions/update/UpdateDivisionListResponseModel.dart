class UpdateDivisionListResponseModel {
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
  String? zohoOrganizationId;
  String? zohoTaxExemptionId;

  UpdateDivisionListResponseModel({
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

  UpdateDivisionListResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    status = json['status'] as String?;
    mobileNo = json['mobile_no'] as String?;
    contactPerson = json['contact_person'] as String?;
    email = json['email'] as String?;
    address = json['address'] as String?;
    logo = json['logo'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    zohoOrganizationId = json['zoho_organization_id'] as String?;
    zohoTaxExemptionId = json['zoho_tax_exemption_id'] as String?;
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

  // Add static method to parse customer_list of JSON objects
  static List<UpdateDivisionListResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => UpdateDivisionListResponseModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}