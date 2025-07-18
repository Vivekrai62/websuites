class FieldSettingResponseModel {
  String? id;
  String? name;
  String? displayName;
  bool? isRequired;
  bool? isStatusFixed;
  String? type;
  List<LeadFieldEditRestrictions>? leadFieldEditRestrictions;
  List<Role>? restrictedRoles; // <-- Fixed: use Role directly

  FieldSettingResponseModel({
    this.id,
    this.name,
    this.displayName,
    this.isRequired,
    this.isStatusFixed,
    this.type,
    this.leadFieldEditRestrictions,
    this.restrictedRoles,
  });

  FieldSettingResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['displayName'];
    isRequired = json['isRequired'];
    isStatusFixed = json['isStatusFixed'];
    type = json['type'];

    if (json['lead_field_edit_restrictions'] != null) {
      leadFieldEditRestrictions = <LeadFieldEditRestrictions>[];
      json['lead_field_edit_restrictions'].forEach((v) {
        leadFieldEditRestrictions!.add(LeadFieldEditRestrictions.fromJson(v));
      });
    }

    if (json['restricted_roles'] != null) {
      restrictedRoles = <Role>[];
      json['restricted_roles'].forEach((v) {
        restrictedRoles!.add(Role.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['displayName'] = displayName;
    data['isRequired'] = isRequired;
    data['isStatusFixed'] = isStatusFixed;
    data['type'] = type;
    if (leadFieldEditRestrictions != null) {
      data['lead_field_edit_restrictions'] =
          leadFieldEditRestrictions!.map((v) => v.toJson()).toList();
    }
    if (restrictedRoles != null) {
      data['restricted_roles'] =
          restrictedRoles!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  /// Optional: List parsing helper
  static List<FieldSettingResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => FieldSettingResponseModel.fromJson(json))
        .toList();
  }
}

class LeadFieldEditRestrictions {
  String? id;
  Role? role;

  LeadFieldEditRestrictions({this.id, this.role});

  LeadFieldEditRestrictions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}

class Role {
  String? id;
  String? name;

  Role({this.id, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
