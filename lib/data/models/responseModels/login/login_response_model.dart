class LoginResponseModel {
  String? accessToken;
  User? user;

  LoginResponseModel({this.accessToken, this.user});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  bool? isAdmin;
  String? crmCategory;
  bool? mobileApp;
  bool? superSettings;
  bool? isWhatsappEnabled;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.isAdmin,
        this.crmCategory,
        this.mobileApp,
        this.superSettings,
        this.isWhatsappEnabled});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    isAdmin = json['is_admin'];
    crmCategory = json['crm_category'];
    mobileApp = json['mobile_app'];
    superSettings = json['superSettings'];
    isWhatsappEnabled = json['isWhatsappEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['is_admin'] = this.isAdmin;
    data['crm_category'] = this.crmCategory;
    data['mobile_app'] = this.mobileApp;
    data['superSettings'] = this.superSettings;
    data['isWhatsappEnabled'] = this.isWhatsappEnabled;
    return data;
  }
}
