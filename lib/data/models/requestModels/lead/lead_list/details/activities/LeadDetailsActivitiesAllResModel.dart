class LeadDetailsAllResModel {
  String? id;
  String? action;
  String? description;
  Details? details;
  String? ipAddress;
  String? lat;
  String? lng;
  String? device;
  String? browser;
  CreatedByUser? createdByUser;
  dynamic department; // Can be null or a complex object
  Lead? lead;
  List<User>? users;
  int? v;
  String? createdAt;
  String? updatedAt;

  LeadDetailsAllResModel({
    this.id,
    this.action,
    this.description,
    this.details,
    this.ipAddress,
    this.lat,
    this.lng,
    this.device,
    this.browser,
    this.createdByUser,
    this.department,
    this.lead,
    this.users,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  LeadDetailsAllResModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    action = json['action'];
    description = json['description'];
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
    ipAddress = json['ipaddress'];
    lat = json['lat'];
    lng = json['lng'];
    device = json['device'];
    browser = json['browser'];
    createdByUser = json['createdByUser'] != null
        ? CreatedByUser.fromJson(json['createdByUser'])
        : null;
    department = json['department'];
    lead = json['lead'] != null ? Lead.fromJson(json['lead']) : null;
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add(User.fromJson(v));
      });
    }
    v = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['action'] = action;
    data['description'] = description;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    data['ipaddress'] = ipAddress;
    data['lat'] = lat;
    data['lng'] = lng;
    data['device'] = device;
    data['browser'] = browser;
    if (createdByUser != null) {
      data['createdByUser'] = createdByUser!.toJson();
    }
    data['department'] = department;
    if (lead != null) {
      data['lead'] = lead!.toJson();
    }
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    data['__v'] = v;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  static List<LeadDetailsAllResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) {
      print("Parsing activity JSON: $json");
      return LeadDetailsAllResModel.fromJson(json);
    }).toList();
  }
}

class Details {
  String? assignedTo;
  String? assignedFrom;

  Details({this.assignedTo, this.assignedFrom});

  Details.fromJson(Map<String, dynamic> json) {
    assignedTo = json['Assigned To'];
    assignedFrom = json['Assigned From'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Assigned To'] = assignedTo;
    data['Assigned From'] = assignedFrom;
    return data;
  }
}

class CreatedByUser {
  String? id;
  String? name;
  String? internalId;

  CreatedByUser({this.id, this.name, this.internalId});

  CreatedByUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    internalId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['_id'] = internalId;
    return data;
  }
}

class Lead {
  String? id;
  String? name;
  String? internalId;

  Lead({this.id, this.name, this.internalId});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    internalId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['_id'] = internalId;
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? internalId;

  User({this.id, this.name, this.internalId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    internalId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['_id'] = internalId;
    return data;
  }
}