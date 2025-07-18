class LeadDetailsAllResModel {
  String? sId;
  String? action;
  String? description;
  Details? details;
  String? ipaddress;
  dynamic lat;
  dynamic lng;
  dynamic device;
  dynamic browser;
  CreatedByUser? createdByUser;
  dynamic department;
  CreatedByUser? lead;
  List<Users>? users;
  int? iV;
  String? createdAt;
  String? updatedAt;

  LeadDetailsAllResModel({
    this.sId,
    this.action,
    this.description,
    this.details,
    this.ipaddress,
    this.lat,
    this.lng,
    this.device,
    this.browser,
    this.createdByUser,
    this.department,
    this.lead,
    this.users,
    this.iV,
    this.createdAt,
    this.updatedAt,
  });

  factory LeadDetailsAllResModel.fromJson(Map<String, dynamic> json) {
    return LeadDetailsAllResModel(
      sId: json['_id'],
      action: json['action'],
      description: json['description'],
      details: json['details'] != null ? Details.fromJson(json['details']) : null,
      ipaddress: json['ipaddress'],
      lat: json['lat'],
      lng: json['lng'],
      device: json['device'],
      browser: json['browser'],
      createdByUser: json['createdByUser'] != null
          ? CreatedByUser.fromJson(json['createdByUser'])
          : null,
      department: json['department'],
      lead: json['lead'] != null ? CreatedByUser.fromJson(json['lead']) : null,
      users: json['users'] != null
          ? List<Users>.from(json['users'].map((x) => Users.fromJson(x)))
          : [],
      iV: json['__v'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'action': action,
      'description': description,
      'details': details?.toJson(),
      'ipaddress': ipaddress,
      'lat': lat,
      'lng': lng,
      'device': device,
      'browser': browser,
      'createdByUser': createdByUser?.toJson(),
      'department': department,
      'lead': lead?.toJson(),
      'users': users?.map((x) => x.toJson()).toList(),
      '__v': iV,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// ✅ Static method to handle List of JSON objects
  static List<LeadDetailsAllResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadDetailsAllResModel.fromJson(json))
        .toList();
  }
}

class Details {
  String? assignedTo;
  String? assignedFrom;

  Details({this.assignedTo, this.assignedFrom});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      assignedTo: json['Assigned To'],
      assignedFrom: json['Assigned From'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Assigned To': assignedTo,
      'Assigned From': assignedFrom,
    };
  }
}

class CreatedByUser {
  String? id;
  String? name;
  String? sId;

  CreatedByUser({this.id, this.name, this.sId});

  factory CreatedByUser.fromJson(Map<String, dynamic> json) {
    return CreatedByUser(
      id: json['id'],
      name: json['name'],
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      '_id': sId,
    };
  }
}

/// Dummy Users class (update with actual fields)
class Users {
  String? name;
  String? role;

  Users({this.name, this.role});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
    };
  }
}
