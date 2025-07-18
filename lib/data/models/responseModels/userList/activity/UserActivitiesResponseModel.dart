class UserActivitiesResponseModel {
  List<Items>? items;
  Meta? meta;

  UserActivitiesResponseModel({this.items, this.meta});

  UserActivitiesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Items {
  String? id;
  String? name;
  String? description;
  String? ipaddress;
  String? lat;
  String? lng;
  String? userAgent;
  String? browserName;
  dynamic osDetail;
  dynamic deviceDetail;
  String? deviceType;
  String? createdAt;
  User? user;

  Items({
    this.id,
    this.name,
    this.description,
    this.ipaddress,
    this.lat,
    this.lng,
    this.userAgent,
    this.browserName,
    this.osDetail,
    this.deviceDetail,
    this.deviceType,
    this.createdAt,
    this.user,
  });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    ipaddress = json['ipaddress'];
    lat = json['lat'];
    lng = json['lng'];
    userAgent = json['user_agent'];
    browserName = json['browser_name'];
    osDetail = json['os_detail'];
    deviceDetail = json['device_detail'];
    deviceType = json['device_type'];
    createdAt = json['created_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['ipaddress'] = ipaddress;
    data['lat'] = lat;
    data['lng'] = lng;
    data['user_agent'] = userAgent;
    data['browser_name'] = browserName;
    data['os_detail'] = osDetail;
    data['device_detail'] = deviceDetail;
    data['device_type'] = deviceType;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;

  User({this.id, this.firstName, this.lastName, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? itemsPerPage;
  int? totalPages;
  int? totalItems;
  int? itemCount;

  Meta({this.currentPage, this.itemsPerPage, this.totalPages, this.totalItems, this.itemCount});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    itemsPerPage = json['itemsPerPage'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['currentPage'] = currentPage;
    data['itemsPerPage'] = itemsPerPage;
    data['totalPages'] = totalPages;
    data['totalItems'] = totalItems;
    data['itemCount'] = itemCount;
    return data;
  }
}