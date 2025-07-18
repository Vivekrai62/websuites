class UserUpdaterRequestModel {
  String? password;
  String? cpassword;
  String? mobile;
  String? email;
  String? lastName;
  String? department;
  String? firstName;
  String? parent;
  List<String>? roleList;

  UserUpdaterRequestModel({
    this.password,
    this.cpassword,
    this.mobile,
    this.email,
    this.lastName,
    this.department,
    this.firstName,
    this.parent,
    this.roleList,
  });

  UserUpdaterRequestModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    cpassword = json['cpassword'];
    mobile = json['mobile'];
    email = json['email'];
    lastName = json['last_name'];
    department = json['department'];
    firstName = json['first_name'];
    parent = json['parent'];
    roleList = json['role_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['password'] = password;
    data['cpassword'] = cpassword;
    data['mobile'] = mobile;
    data['email'] = email;
    data['last_name'] = lastName;
    data['department'] = department;
    data['first_name'] = firstName;
    data['parent'] = parent;
    data['role_list'] = roleList;
    return data;
  }
}
