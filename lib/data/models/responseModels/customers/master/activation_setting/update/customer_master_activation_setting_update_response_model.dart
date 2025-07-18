import '../customer_master_activtaion_setting_response_model.dart';

class ActivationSettingUpdateResponseModel {
  String? id;
  bool? isSentCustomer;
  String? createdAt;
  String? updatedAt;
  MailTo? mailTo;
  List<CcUsers>? ccUsers;

  ActivationSettingUpdateResponseModel(
      {this.id,
      this.isSentCustomer,
      this.createdAt,
      this.updatedAt,
      this.mailTo,
      this.ccUsers});

  ActivationSettingUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSentCustomer = json['is_sent_customer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mailTo = json['mail_to'] != null ? MailTo.fromJson(json['mail_to']) : null;
    if (json['cc_users'] != null) {
      ccUsers = <CcUsers>[];
      json['cc_users'].forEach((v) {
        ccUsers!.add(CcUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_sent_customer'] = isSentCustomer;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (mailTo != null) {
      data['mail_to'] = mailTo!.toJson();
    }
    if (ccUsers != null) {
      data['cc_users'] = ccUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MailTo {
  String? id;

  MailTo({this.id});

  MailTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
