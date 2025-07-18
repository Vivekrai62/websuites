class AddDivisionResponseModels {
  String? name;
  String? mobileNo;
  String? contactPerson;
  String? email;
  String? address;
  String? logo;
  String? zohoOrganizationId;
  String? zohoTaxExemptionId;
  String? id;
  String? status;
  String? createdAt;
  String? updatedAt;


  AddDivisionResponseModels({
    this.name,
    this.mobileNo,
    this.contactPerson,
    this.email,
    this.address,
    this.logo,
    this.zohoOrganizationId,
    this.zohoTaxExemptionId,
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  // From JSON constructor
  AddDivisionResponseModels.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    mobileNo = json['mobile_no'] as String?;
    contactPerson = json['contact_person'] as String?;
    email = json['email'] as String?;
    address = json['address'] as String?;
    logo = json['logo'] as String?;
    zohoOrganizationId = json['zoho_organization_id'] as String?;
    zohoTaxExemptionId = json['zoho_tax_exemption_id'] as String?;
    id = json['id'] as String?;
    status = json['status'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['mobile_no'] = mobileNo;
    data['contact_person'] = contactPerson;
    data['email'] = email;
    data['address'] = address;
    data['logo'] = logo;
    data['zoho_organization_id'] = zohoOrganizationId;
    data['zoho_tax_exemption_id'] = zohoTaxExemptionId;
    data['id'] = id;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
