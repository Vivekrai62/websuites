class UsersResponseModel {
  List<Items>? items;
  Meta? meta;
  String? user_key;

  UsersResponseModel ({
    this.items,
    this.meta,
    this.user_key
});

  UsersResponseModel.fromJson(Map<String, dynamic> json) {
    if(json['items'] != null) {
      items = <Items> [];
      json['items'].forEach((v){
        items!.add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    user_key = json['user_key'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    if(items != null) {
      data['items'] = items !. map((v) => toJson()).toList();
    }
    if(meta != null){
    data['meta'] = meta !. toJson();
    }
    data['user_key'] = user_key;
    return data;
  }
}

class Items {
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
  Department? department;
  Parent? parent;
  List<RoleList>? role_list;

  Items({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.mobile,
    this.address,
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
    this.superSettings,
    this.department,
    this.parent,
    this.role_list,
});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    status = json['status'];
    remember_token = json['remember_token'];
    remember_token_time = json['remember_token_time'];
    isdefault = json['isdefault'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    device_id = json['device_id'];
    tracking = json['tracking'];
    crm_category = json['crm_category'];
    mobile_app = json['mobile'];
    superSettings = json['superSettings'];
    department = json['department'] != null ? Department.fromJson(json['department']) : null;
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
    if(json['role_list'] != null) {
      role_list = <RoleList>[];
      json['role_list'].forEach((v){
        role_list !.add(RoleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['address'] = address;
    data['status'] = status;
    data['remember_token'] = remember_token;
    data['remember_token_time'] = remember_token_time;
    data['isdefault'] = isdefault;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['device_at'] = device_id;
    data['crm_category'] = crm_category;
    data['mobile_app'] = mobile_app;
    data['superSettings'] = superSettings;
    data['department'] = department;
    data['parent'] = parent;
    if(role_list != null) {
      data['role_list'] = role_list !. map((v) => toJson()).toList();
    }
    return data;
  }
}
class Department {
  String? id;
  String? name;
  String? description;
  String? isdefault;
  String? created_at;
  String? updated_at;

  Department({
    this.id,
    this.name,
    this.description,
    this.updated_at,
    this.created_at,
    this.isdefault
});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    updated_at = json['updated_at'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['updated_at'] = updated_at;
    data['created_at'] = created_at;
    return data;
  }
}

class Parent {
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

  Parent({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.mobile,
    this.address,
    this.bio,
    this.profile_pic,
    this.password,
    this.remember_token_time,
    this.remember_token,
    this.isdefault,
    this.created_at,
    this.updated_at,
    this.device_id,
    this.tracking,
    this.crm_category,
    this.mobile_app,
    this.superSettings
});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    bio = json['bio'];
    profile_pic = json['profile_pic'];
    password = json['password'];
    remember_token = json['remember_token'];
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

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic>{};
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

class RoleList {
  String? id;
  String? name;
  String? description;
  bool? isdefault;

  RoleList({
    this.id,
    this.name,
    this.description,
    this.isdefault
});

  RoleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isdefault = json['isdefault'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['isdefault'] = isdefault;
    return data;
  }
}


class Meta {
  int? currentPage;
  int? itemsPerPage;
  int? totalPages;
  int? totalItems;
  int? itemCount;

  Meta({
    this.currentPage,
    this.itemsPerPage,
    this.totalPages,
    this.totalItems,
    this.itemCount
});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    itemsPerPage = json['itemsPerPage'];
    totalPages = json['totalPages'];
    itemCount = json['itemCount'];
    totalItems = json['totalItems'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['currentPage'] = currentPage;
    data['itemsPerPage'] = itemsPerPage;
    data['totalPages'] = totalPages;
    data['itemCount'] = itemCount;
    data['totalItems'] = totalItems;
    return data;
  }

}