class CampaignListResponseModel {
  List<Items>? items;
  Meta? meta;
  Statistics? statistics;
  String? userKey;

  CampaignListResponseModel ({
    this.items,
    this.meta,
    this.userKey,
    this.statistics
});

  CampaignListResponseModel.fromJson(Map<String, dynamic> json){
    if(json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v){
        items !. add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    statistics = json['statistics'] != null ? Statistics.fromJson(json['statistics']) : null;
    userKey = json['user_key'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    data['user_key'] = userKey;
    return data;
  }
}

class Items {
  String? id;
  String? mode;
  String? campaign_name;
  String? display_name;
  String? email_subject;
  String? message;
  String? status;
  String? campaign_on;
  String? schedule_at;
  String? mailjet_campaign_id;
  String? mailjet_draft_id;
  String? brevo_campaign_id;
  String? created_at;
  String? updated_at;
  String? delete_at;
  String? failed_reason;
  CreatedBy? created_by;
  Template? template;

  Items({
    this.id,
    this.mode,
    this.campaign_name,
    this.display_name,
    this.email_subject,
    this.message,
    this.status,
    this.campaign_on,
    this.schedule_at,
    this.mailjet_campaign_id,
    this.mailjet_draft_id,
    this.created_at,
    this.updated_at,
    this.delete_at,
    this.failed_reason,
    this.created_by,
    this.template,
    this.brevo_campaign_id
});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mode = json['mode'];
    campaign_name = json['campaign_name'];
    display_name = json['display_name'];
    email_subject = json['email_subject'];
    message = json['message'];
    status = json['status'];
    campaign_on = json['campaign_on'];
    schedule_at = json['schedule_at'];
    mailjet_draft_id = json['mailjet_draft_id'];
    created_by = json['created_by'];
    updated_at = json['updated_at'];
    delete_at = json['delete_at'];
    failed_reason = json['failed_reason'];
    created_by = json['created_by'] != null ? CreatedBy.fromJson(json['CreatedBy']) : null;
    template = json['template'];
    brevo_campaign_id = json['brevo_campaign_id'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['mode'] = mode;
    data['campaign_name'] = campaign_name;
    data['display_name'] = display_name;
    data['email_subject'] = email_subject;
    data['message'] = message;
    data['status'] = status;
    data['campaign_on'] = campaign_on;
    data['schedule_at'] = schedule_at;
    data['mailjet_draft_id'] = mailjet_draft_id;
    data['created_by'] = created_by;
    data['updated_at'] = updated_at;
    data['delete_at'] = delete_at;
    data['failed_reason'] = failed_reason;
    if(created_by != null) {
      data['created_by'] = created_by !. toJson();
    }
    if(template != null) {
      data['template'] = template !. toJson();
    }
    data['brevo_campaign_id'] = brevo_campaign_id;
    return data;
  }
}

class CreatedBy {
  String? id;
  String? first_name;
  String? last_name;
  String? email;
  String? mobile;
  String? address;
  String? bio;
  String? profile_pic;
  String? password;
  bool? status;
  String? remember_token;
  String? remember_token_time;
  bool? isdefault;
  String? created_at;
  String? updated_at;
  String? device_id;
  bool? tracking;
  String? crm_category;
  bool? mobile_app;
  bool? superSettings;

  CreatedBy({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.mobile,
    this.address,
    this.bio,
    this.profile_pic,
    this.password,
    this.status,
    this.remember_token,
    this.remember_token_time,
    this.isdefault,
    this.created_at,
    this.updated_at,
    this.device_id,
    this.tracking,
    this.crm_category,
    this.mobile_app,
    this.superSettings
});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    bio = json['bio'];
    profile_pic = json['profile_pic'];
    password = json['password'];
    status = json['status'];
    remember_token_time = json['remember_token_time'];
    isdefault = json['isdefault'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    device_id = json['device_id'];
    tracking = json['tracking'];
    crm_category = json['crm_category'];
    mobile_app = json['mobile_app'];
    superSettings = json['superSettings'];
  }

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['address'] = address;
    data['bio'] = bio;
    data['profile_pic'] = profile_pic;
    data['password'] = password;
    data['status'] = status;
    data['remember_token'] = remember_token;
    data['remember_token_time'] = remember_token_time;
    data['isdefault'] = isdefault;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['device_id'] = device_id;
    data['tracking'] = tracking;
    data['crm_category'] = crm_category;
    data['mobile_app'] = mobile_app;
    data['superSettings'] = superSettings;
    return data;
  }
}

class Template {
  String? id;
  String? name;

  Template({
    this.id,
    this.name
});

  Template.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Meta {
int? currentPage;
int? itemsPerPage;
int? totalItems;
int? totalCount;
int? itemCount;

Meta({
  this.currentPage,
  this.itemCount,
  this.totalItems,
  this.totalCount,
  this.itemsPerPage});

Meta.fromJson(Map<String, dynamic> json) {
  currentPage = json['currentPage'];
  itemCount = json['itemCount'];
  totalItems = json['totalItems'];
  totalCount = json['totalCount'];
  itemsPerPage = json['itemsPerPage'];
}

Map<String, dynamic> toJson (){
  final Map<String, dynamic> data = <String, dynamic> {};
  data['currentPage'] = currentPage;
  data['itemCount'] = itemCount;
  data['totalItems'] = totalItems;
  data['totalCount'] = totalCount;
  data['itemsPerPage'] = itemsPerPage;
  return data;
}
}


class Statistics{
  Quota? quota;
  Limit? limit;
  UsedLimit? used_limit;

  Statistics({this.quota, this.limit, this.used_limit});

  Statistics.fromJson(Map<String, dynamic> json) {
    quota = json['quota'] != null ? Quota.fromJson(json['quota']) : null;
    limit = json['limit'] != null ? Limit.fromJson(json['quota']) : null;
    used_limit = json['used_limit'] != null ? UsedLimit.fromJson(json['used_limit']) : null;
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    if(quota != null) {
      data['quota'] = quota!.toJson();
    }
    if(limit != null) {
      data['limit'] = limit!.toJson();
    }
    if(used_limit != null) {
      data['used_limit'] = used_limit !.toJson();
    }
    return data;
  }


}

class Quota{
  int? email_limit;
  int? whatsapp_limit;
  int? sms_limit;

  Quota({this.email_limit, this.sms_limit, this.whatsapp_limit});

  Quota.fromJson(Map<String, dynamic> json) {
    email_limit = json['email_limit'];
    sms_limit = json['sms_limit'];
    whatsapp_limit = json['whatsapp_limit'];
  }
  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['email_limit'] = email_limit;
    data['sms_limit'] = sms_limit;
    data['whatsapp_limit'] = whatsapp_limit;
    return data;
  }
}

class Limit {
  int? email_limit;
  int? whatsapp_limit;
  int? sms_limit;

  Limit({this.email_limit, this.sms_limit, this.whatsapp_limit});

  Limit.fromJson(Map<String, dynamic> json) {
    email_limit = json['email_limit'];
    sms_limit = json['sms_limit'];
    whatsapp_limit = json['whatsapp_limit'];
  }
  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['email_limit'] = email_limit;
    data['sms_limit'] = sms_limit;
    data['whatsapp_limit'] = whatsapp_limit;
    return data;
  }
}

class UsedLimit {
  int? email_used;
  int? whatsapp_used;
  int? sms_used;

  UsedLimit({this.email_used, this.sms_used, this.whatsapp_used});

  UsedLimit.fromJson(Map<String, dynamic> json) {
    email_used = json['email_limit'];
    sms_used = json['sms_limit'];
    whatsapp_used = json['whatsapp_limit'];
  }
  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['email_limit'] = email_used;
    data['sms_limit'] = sms_used;
    data['whatsapp_limit'] = whatsapp_used;
    return data;
  }
}
