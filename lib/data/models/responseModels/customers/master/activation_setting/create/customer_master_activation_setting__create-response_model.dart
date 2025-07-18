import '../customer_master_activtaion_setting_response_model.dart';

class ActivationSettingCreateResponseModel {
  bool? isSentCustomer;
  Service? service;
  Service? mailTo;
  List<CcUsers>? ccUsers;
  Service? createdBy;
  String? id;
  String? createdAt;
  String? updatedAt;

  ActivationSettingCreateResponseModel(
      {this.isSentCustomer,
      this.service,
      this.mailTo,
      this.ccUsers,
      this.createdBy,
      this.id,
      this.createdAt,
      this.updatedAt});

  ActivationSettingCreateResponseModel.fromJson(Map<String, dynamic> json) {
    isSentCustomer = json['is_sent_customer'];
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
    mailTo = json['mail_to'] != null ? Service.fromJson(json['mail_to']) : null;
    if (json['cc_users'] != null) {
      ccUsers = <CcUsers>[];
      json['cc_users'].forEach((v) {
        ccUsers!.add(CcUsers.fromJson(v));
      });
    }
    createdBy = json['created_by'] != null
        ? Service.fromJson(json['created_by'])
        : null;
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_sent_customer'] = isSentCustomer;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (mailTo != null) {
      data['mail_to'] = mailTo!.toJson();
    }
    if (ccUsers != null) {
      data['cc_users'] = ccUsers!.map((v) => ()).toList();
    }
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Service {
  String? id;

  Service({this.id});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
