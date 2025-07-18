// lead_setting_response_model.dart

class LeadSettingResponseModel {
  final String id;
  final String leadField;
  final String fieldName;
  final bool locked;
  final int score;
  final bool scorable;
  final int order;
  final String type;
  final bool allowGlobalSearch;
  final bool status;
  final bool filter;
  final bool allowedInLeadsList;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<HideLeadColumnFromRole> hideLeadColumnsFromRole;
  final List<Role> restrictedRoles;

  LeadSettingResponseModel({
    required this.id,
    required this.leadField,
    required this.fieldName,
    required this.locked,
    required this.score,
    required this.scorable,
    required this.order,
    required this.type,
    required this.allowGlobalSearch,
    required this.status,
    required this.filter,
    required this.allowedInLeadsList,
    required this.createdAt,
    required this.updatedAt,
    required this.hideLeadColumnsFromRole,
    required this.restrictedRoles,
  });

  factory LeadSettingResponseModel.fromJson(Map<String, dynamic> json) {
    return LeadSettingResponseModel(
      id: json['id'] as String,
      leadField: json['lead_field'] as String,
      fieldName: json['field_name'] as String,
      locked: json['locked'] as bool,
      score: json['score'] as int,
      scorable: json['scorable'] as bool,
      order: json['order'] as int,
      type: json['type'] as String,
      allowGlobalSearch: json['allowGlobalSearch'] as bool,
      status: json['status'] as bool,
      filter: json['filter'] as bool,
      allowedInLeadsList: json['allowedInLeadsList'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      hideLeadColumnsFromRole: (json['hide_lead_columns_from_role'] as List)
          .map((e) => HideLeadColumnFromRole.fromJson(e as Map<String, dynamic>))
          .toList(),
      restrictedRoles: (json['restricted_roles'] as List)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  static List<LeadSettingResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadSettingResponseModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lead_field': leadField,
      'field_name': fieldName,
      'locked': locked,
      'score': score,
      'scorable': scorable,
      'order': order,
      'type': type,
      'allowGlobalSearch': allowGlobalSearch,
      'status': status,
      'filter': filter,
      'allowedInLeadsList': allowedInLeadsList,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'hide_lead_columns_from_role':
      hideLeadColumnsFromRole.map((e) => e.toJson()).toList(),
      'restricted_roles': restrictedRoles.map((e) => e.toJson()).toList(),
    };
  }
}

class HideLeadColumnFromRole {
  final String id;
  final Role role;

  HideLeadColumnFromRole({
    required this.id,
    required this.role,
  });

  factory HideLeadColumnFromRole.fromJson(Map<String, dynamic> json) {
    return HideLeadColumnFromRole(
      id: json['id'] as String,
      role: Role.fromJson(json['role'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role.toJson(),
    };
  }
}

class Role {
  final String id;
  final String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}