class AddDivisionRequestModels {
  String? name;
  String? mobileNo;
  String? contactPerson;
  String? email;
  String? address;
  String? logo;

  AddDivisionRequestModels(
      {this.name,
      this.mobileNo,
      this.contactPerson,
      this.email,
      this.address,
      this.logo});

  AddDivisionRequestModels.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobileNo = json['mobile_no'];
    contactPerson = json['contact_person'];
    email = json['email'];
    address = json['address'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['mobile_no'] = mobileNo;
    data['contact_person'] = contactPerson;
    data['email'] = email;
    data['address'] = address;
    data['logo'] = logo;
    return data;
  }
}
