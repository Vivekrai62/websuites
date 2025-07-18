class UpdateDivisionRequestModels {
  String? name;
  String? mobileNo;
  String? contactPerson;
  String? email;
  String? address;
  String? logo;
  String? status;
  String? zohoOrganizationId;
  String? zohoTaxExemptionId;
  String? id;
  String? createdAt;
  String? updatedAt;

  // Constructor with nullable fields
  UpdateDivisionRequestModels({
    this.name,
    this.mobileNo,
    this.contactPerson,
    this.email,
    this.address,
    this.logo,
    this.status,
    this.zohoOrganizationId,
    this.zohoTaxExemptionId,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  // From JSON constructor
  UpdateDivisionRequestModels.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    mobileNo = json['mobile_no'] as String?;
    contactPerson = json['contact_person'] as String?;
    email = json['email'] as String?;
    address = json['address'] as String?;
    logo = json['logo'] as String?;
    status = json['status'] as String?;
    zohoOrganizationId = json['zoho_organization_id'] as String?;
    zohoTaxExemptionId = json['zoho_tax_exemption_id'] as String?;
    id = json['id'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (mobileNo != null) data['mobile_no'] = mobileNo;
    if (contactPerson != null) data['contact_person'] = contactPerson;
    if (email != null) data['email'] = email;
    if (address != null) data['address'] = address;
    if (logo != null) data['logo'] = logo;
    if (status != null) data['status'] = status;
    if (zohoOrganizationId != null) data['zoho_organization_id'] = zohoOrganizationId;
    if (zohoTaxExemptionId != null) data['zoho_tax_exemption_id'] = zohoTaxExemptionId;
    if (id != null) data['id'] = id;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    return data;
  }
}