// class DeleteListResponseModel {
//   List<Items>? items;
//   Meta? meta;
//
//   DeleteListResponseModel({this.items, this.meta});
//
//   DeleteListResponseModel.fromJson(Map<String, dynamic> json) {
//     if (json['items'] != null) {
//       items = <Items>[];
//       json['items'].forEach((v) {
//         items!.add(Items.fromJson(v));
//       });
//     }
//     meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (items != null) {
//       data['items'] = items!.map((v) => v.toJson()).toList();
//     }
//     if (meta != null) {
//       data['meta'] = meta!.toJson();
//     }
//     return data;
//   }
// }
//
// class Items {
//   String? id;
//   int? score;
//   String? first_name;
//   String? last_name;
//   int? country_code;
//   String? mobile;
//   String? mobile_with_countrycode;
//   String? email;
//   String? address;
//   String? organization;
//   String? city;
//   String? state;
//   String? description;
//   int? flag;
//   ImportCustomData? import_custom_data;
//   String? query_time;
//   String? query_type;
//   String? ref_id;
//   Null lead_buyer_email;
//   Null lead_buyer_name;
//   Null label;
//   Null note;
//   String? delete_remark;
//   String? created_id;
//   String? updated_id;
//   String? deleted_at;
//   String? oldLead;
//   bool? isOldLead;
//   Null facebookLeadgenId;
//   String? latest_enquiry_date;
//   Type? type;
//   DeletedBy? deleted_by;
//
//   Items(
//       {this.id,
//       this.score,
//       this.first_name,
//       this.last_name,
//       this.country_code,
//       this.mobile,
//       this.mobile_with_countrycode,
//       this.email,
//       this.address,
//       this.organization,
//       this.city,
//       this.state,
//       this.description,
//       this.flag,
//       this.import_custom_data,
//       this.query_time,
//       this.query_type,
//       this.ref_id,
//       this.lead_buyer_email,
//       this.lead_buyer_name,
//       this.label,
//       this.note,
//       this.deleted_at,
//       this.created_id,
//       this.updated_id,
//       this.deleted_by,
//       this.oldLead,
//       this.isOldLead,
//       this.facebookLeadgenId,
//       this.latest_enquiry_date,
//       this.type,
//       this.delete_remark});
//
//   Items.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     score = json['score'];
//     first_name = json['first_name'];
//     last_name = json['last_name'];
//     country_code = json['country_code'];
//     mobile = json['mobile'];
//     mobile_with_countrycode = json['mobile_with_countrycode'];
//     email = json['email'];
//     address = json['address'];
//     organization = json['organization'];
//     city = json['city'];
//     state = json['state'];
//     description = json['description'];
//     flag = json['flag'];
//     import_custom_data = json['import_custom_data'] != null
//         ? ImportCustomData.fromJson(json['import_custom_data'])
//         : null;
//     query_time = json['query_time'];
//     query_type = json['query_type'];
//     ref_id = json['ref_id'];
//     lead_buyer_email = json['lead_buyer_email'];
//     lead_buyer_name = json['lead_buyer_name'];
//     label = json['label'];
//     note = json['note'];
//     delete_remark = json['delete_remark'];
//     created_id = json['created_at'];
//     updated_id = json['updated_at'];
//     deleted_at = json['deleted_at'];
//     oldLead = json['old_lead'];
//     isOldLead = json['isOldLead'];
//     facebookLeadgenId = json['facebookLeadgenId'];
//     latest_enquiry_date = json['latest_enquiry_date'];
//     type = json['type'] != null ? Type.fromJson(json['type']) : null;
//     deleted_by = json['deleted_by'] != null
//         ? DeletedBy.fromJson(json['deleted_by'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['score'] = score;
//     data['first_name'] = first_name;
//     data['last_name'] = last_name;
//     data['country_code'] = country_code;
//     data['mobile'] = mobile;
//     data['mobile_with_countrycode'] = mobile_with_countrycode;
//     data['email'] = email;
//     data['address'] = address;
//     data['organization'] = organization;
//     data['city'] = city;
//     data['state'] = state;
//     data['description'] = description;
//     data['flag'] = flag;
//     if (import_custom_data != null) {
//       data['import_custom_data'] = import_custom_data!.toJson();
//     }
//     data['query_time'] = query_time;
//     data['query_type'] = query_type;
//     data['ref_id'] = ref_id;
//     data['lead_buyer_email'] = lead_buyer_email;
//     data['lead_buyer_name'] = lead_buyer_name;
//     data['label'] = label;
//     data['note'] = note;
//     data['delete_remark'] = delete_remark;
//     data['created_at'] = created_id;
//     data['updated_at'] = updated_id;
//     data['deleted_at'] = deleted_at;
//     data['old_lead'] = oldLead;
//     data['isOldLead'] = isOldLead;
//     data['facebookLeadgenId'] = facebookLeadgenId;
//     data['latest_enquiry_date'] = latest_enquiry_date;
//     if (type != null) {
//       data['type'] = type!.toJson();
//     }
//     if (deleted_by != null) {
//       data['deleted_by'] = deleted_by!.toJson();
//     }
//     return data;
//   }
// }
//
// class ImportCustomData {
//   List<String>? divisions;
//   List<String>? services;
//   List<Data>? data;
//
//   ImportCustomData({this.divisions, this.services, this.data});
//
//   ImportCustomData.fromJson(Map<String, dynamic> json) {
//     divisions = json['divisions'].cast<String>();
//     services = json['services'].cast<String>();
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['divisions'] = divisions;
//     data['services'] = services;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   Null gst_number;
//   Null drug_license;
//   Null website_link;
//   Null ind_type;
//   String? industry;
//   Null designation;
//   Null pincode;
//   String? companyName;
//
//   Data(
//       {this.gst_number,
//       this.drug_license,
//       this.website_link,
//       this.ind_type,
//       this.industry,
//       this.designation,
//       this.pincode,
//       this.companyName});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     gst_number = json['gst_number'];
//     drug_license = json['drug_license'];
//     website_link = json['website_link'];
//     ind_type = json['ind_type'];
//     industry = json['industry'];
//     designation = json['designation'];
//     pincode = json['pincode'];
//     companyName = json['company_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['gst_number'] = gst_number;
//     data['drug_license'] = drug_license;
//     data['website_link'] = website_link;
//     data['ind_type'] = ind_type;
//     data['industry'] = industry;
//     data['designation'] = designation;
//     data['pincode'] = pincode;
//     data['company_name'] = companyName;
//     return data;
//   }
// }
//
// class Type {
//   String? id;
//   String? name;
//   Null sub_types;
//   String? status;
//   String? created_at;
//   String? updated_at;
//   int? activity_chart_interval;
//   Null activity_chart_label_y;
//   String? activity_chart_label_x;
//   bool? isReminderRequired;
//   bool? remove_from_todo;
//   bool? remove_from_list;
//
//   Type(
//       {this.id,
//       this.name,
//       this.sub_types,
//       this.status,
//       this.created_at,
//       this.updated_at,
//       this.activity_chart_interval,
//       this.activity_chart_label_y,
//       this.activity_chart_label_x,
//       this.isReminderRequired,
//       this.remove_from_todo,
//       this.remove_from_list});
//
//   Type.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     sub_types = json['sub_types'];
//     status = json['status'];
//     created_at = json['created_at'];
//     updated_at = json['updated_at'];
//     activity_chart_interval = json['activity_chart_interval'];
//     activity_chart_label_y = json['activity_chart_label_y'];
//     activity_chart_label_y = json['activity_chart_label_x'];
//     isReminderRequired = json['isReminderRequired'];
//     remove_from_todo = json['remove_from_todo'];
//     remove_from_list = json['remove_from_list'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['sub_types'] = sub_types;
//     data['status'] = status;
//     data['created_at'] = created_at;
//     data['updated_at'] = updated_at;
//     data['activity_chart_interval'] = activity_chart_interval;
//     data['activity_chart_label_y'] = activity_chart_label_y;
//     data['activity_chart_label_x'] = activity_chart_label_x;
//     data['isReminderRequired'] = isReminderRequired;
//     data['remove_from_todo'] = remove_from_todo;
//     data['remove_from_list'] = remove_from_list;
//     return data;
//   }
// }
//
// class DeletedBy {
//   String? id;
//   String? first_name;
//   String? last_name;
//   String? email;
//   String? mobile;
//   String? address;
//   String? bio;
//   String? profile_pic;
//   String? password;
//   bool? status;
//   String? remember_token;
//   String? remember_token_time;
//   bool? isdefault;
//   String? created_at;
//   String? updated_at;
//   String? device_id;
//   bool? tracking;
//   String? crm_category;
//   bool? mobile_app;
//   bool? superSettings;
//
//   DeletedBy(
//       {this.id,
//       this.first_name,
//       this.last_name,
//       this.email,
//       this.mobile,
//       this.address,
//       this.bio,
//       this.profile_pic,
//       this.password,
//       this.status,
//       this.remember_token,
//       this.remember_token_time,
//       this.isdefault,
//       this.created_at,
//       this.updated_at,
//       this.device_id,
//       this.tracking,
//       this.crm_category,
//       this.mobile_app,
//       this.superSettings});
//
//   DeletedBy.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     first_name = json['first_name'];
//     last_name = json['last_name'];
//     email = json['email'];
//     mobile = json['mobile'];
//     address = json['address'];
//     bio = json['bio'];
//     profile_pic = json['profile_pic'];
//     password = json['password'];
//     status = json['status'];
//     remember_token = json['remember_token'];
//     remember_token_time = json['remember_token_time'];
//     isdefault = json['default'];
//     created_at = json['created_at'];
//     updated_at = json['updated_at'];
//     device_id = json['device_id'];
//     tracking = json['tracking'];
//     crm_category = json['crm_category'];
//     mobile_app = json['mobile_app'];
//     superSettings = json['superSettings'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['first_name'] = first_name;
//     data['last_name'] = last_name;
//     data['email'] = email;
//     data['mobile'] = mobile;
//     data['address'] = address;
//     data['bio'] = bio;
//     data['profile_pic'] = profile_pic;
//     data['password'] = password;
//     data['status'] = status;
//     data['remember_token'] = remember_token;
//     data['remember_token_time'] = remember_token_time;
//     data['default'] = isdefault;
//     data['created_at'] = created_at;
//     data['updated_at'] = updated_at;
//     data['device_id'] = device_id;
//     data['tracking'] = tracking;
//     data['crm_category'] = crm_category;
//     data['mobile_app'] = mobile;
//     data['superSettings'] = superSettings;
//     return data;
//   }
// }
//
// class Meta {
//   int? currentPage;
//   int? itemsPerPage;
//   int? totalPages;
//   int? totalItems;
//   int? itemCount;
//
//   Meta(
//       {this.currentPage,
//       this.itemsPerPage,
//       this.totalPages,
//       this.totalItems,
//       this.itemCount});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     currentPage = json['currentPage'];
//     itemsPerPage = json['itemsPerPage'];
//     totalPages = json['totalPages'];
//     totalItems = json['totalItems'];
//     itemCount = json['itemCount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['currentPage'] = currentPage;
//     data['itemsPerPage'] = itemsPerPage;
//     data['totalPages'] = totalPages;
//     data['totalItems'] = totalItems;
//     data['itemCount'] = itemCount;
//     return data;
//   }
// }









class DeleteListResponseModel {
  List<Item>? items;
  Meta? meta;

  DeleteListResponseModel({this.items, this.meta});

  DeleteListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(Item.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Item {
  String? id;
  int? score;
  String? firstName;
  String? lastName;
  int? countryCode;
  String? mobile;
  String? mobileWithCountryCode;
  String? email;
  String? address;
  String? organization;
  String? city;
  String? state;
  String? description;
  int? flag;
  ImportCustomData? importCustomData;
  String? queryTime;
  String? queryType;
  String? refId;
  String? leadBuyerEmail;
  String? leadBuyerName;
  String? label;
  String? note;
  String? deleteRemark;
  String? createdId;
  String? updatedId;
  String? deletedAt;
  String? oldLead;
  bool? isOldLead;
  String? facebookLeadgenId;
  String? latestEnquiryDate;
  Type? type;
  DeletedBy? deletedBy;

  Item({
    this.id,
    this.score,
    this.firstName,
    this.lastName,
    this.countryCode,
    this.mobile,
    this.mobileWithCountryCode,
    this.email,
    this.address,
    this.organization,
    this.city,
    this.state,
    this.description,
    this.flag,
    this.importCustomData,
    this.queryTime,
    this.queryType,
    this.refId,
    this.leadBuyerEmail,
    this.leadBuyerName,
    this.label,
    this.note,
    this.deleteRemark,
    this.createdId,
    this.updatedId,
    this.deletedAt,
    this.oldLead,
    this.isOldLead,
    this.facebookLeadgenId,
    this.latestEnquiryDate,
    this.type,
    this.deletedBy,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    score = json['score'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    mobileWithCountryCode = json['mobile_with_countrycode'];
    email = json['email'];
    address = json['address'];
    organization = json['organization'];
    city = json['city'];
    state = json['state'];
    description = json['description'];
    flag = json['flag'];
    importCustomData = json['import_custom_data'] != null
        ? ImportCustomData.fromJson(json['import_custom_data'])
        : null;
    queryTime = json['query_time'];
    queryType = json['query_type'];
    refId = json['ref_id'];
    leadBuyerEmail = json['lead_buyer_email'];
    leadBuyerName = json['lead_buyer_name'];
    label = json['label'];
    note = json['note'];
    deleteRemark = json['delete_remark'];
    createdId = json['created_id'];
    updatedId = json['updated_id'];
    deletedAt = json['deleted_at'];
    oldLead = json['old_lead'];
    isOldLead = json['isOldLead'];
    facebookLeadgenId = json['facebookLeadgenId'];
    latestEnquiryDate = json['latest_enquiry_date'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    deletedBy = json['deleted_by'] != null
        ? DeletedBy.fromJson(json['deleted_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['score'] = score;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['mobile_with_countrycode'] = mobileWithCountryCode;
    data['email'] = email;
    data['address'] = address;
    data['organization'] = organization;
    data['city'] = city;
    data['state'] = state;
    data['description'] = description;
    data['flag'] = flag;
    if (importCustomData != null) {
      data['import_custom_data'] = importCustomData!.toJson();
    }
    data['query_time'] = queryTime;
    data['query_type'] = queryType;
    data['ref_id'] = refId;
    data['lead_buyer_email'] = leadBuyerEmail;
    data['lead_buyer_name'] = leadBuyerName;
    data['label'] = label;
    data['note'] = note;
    data['delete_remark'] = deleteRemark;
    data['created_id'] = createdId;
    data['updated_id'] = updatedId;
    data['deleted_at'] = deletedAt;
    data['old_lead'] = oldLead;
    data['isOldLead'] = isOldLead;
    data['facebookLeadgenId'] = facebookLeadgenId;
    data['latest_enquiry_date'] = latestEnquiryDate;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    if (deletedBy != null) {
      data['deleted_by'] = deletedBy!.toJson();
    }
    return data;
  }
}

class ImportCustomData {
  List<String>? divisions;
  List<String>? services;
  List<Data>? data;

  ImportCustomData({this.divisions, this.services, this.data});

  ImportCustomData.fromJson(Map<String, dynamic> json) {
    divisions = json['divisions']?.cast<String>();
    services = json['services']?.cast<String>();
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['divisions'] = divisions;
    data['services'] = services;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? industry;
  String? companyName;

  Data({this.industry, this.companyName});

  Data.fromJson(Map<String, dynamic> json) {
    industry = json['industry'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['industry'] = industry;
    data['company_name'] = companyName;
    return data;
  }
}

class Type {
  String? id;
  String? name;
  String? status;
  bool? isReminderRequired;
  bool? removeFromTodo;
  bool? removeFromList;

  Type({
    this.id,
    this.name,
    this.status,
    this.isReminderRequired,
    this.removeFromTodo,
    this.removeFromList,
  });

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    isReminderRequired = json['isReminderRequired'];
    removeFromTodo = json['remove_from_todo'];
    removeFromList = json['remove_from_list'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['isReminderRequired'] = isReminderRequired;
    data['remove_from_todo'] = removeFromTodo;
    data['remove_from_list'] = removeFromList;
    return data;
  }
}

class DeletedBy {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;

  DeletedBy({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
  });

  DeletedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    return data;
  }
}

class Meta {
  int? totalItems;
  int? itemCount;
  int? itemsPerPage;
  int? totalPages;
  int? currentPage;

  Meta({
    this.totalItems,
    this.itemCount,
    this.itemsPerPage,
    this.totalPages,
    this.currentPage,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    itemCount = json['itemCount'];
    itemsPerPage = json['itemsPerPage'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalItems'] = totalItems;
    data['itemCount'] = itemCount;
    data['itemsPerPage'] = itemsPerPage;
    data['totalPages'] = totalPages;
    data['currentPage'] = currentPage;
    return data;
  }
}













