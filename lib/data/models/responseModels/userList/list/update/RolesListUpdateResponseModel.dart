class RolesListUpdateResponseModel {
  String? id;
  String? name;
  String? displayName;
  String? aliasName;
  String? type;
  String? description;
  String? version;
  String? status;
  String? releaseDate;
  String? createdAt;
  String? updatedAt;
  bool? isEnabled;
  List<Permissions>? permissions;

  RolesListUpdateResponseModel({
    this.id,
    this.name,
    this.displayName,
    this.aliasName,
    this.type,
    this.description,
    this.version,
    this.status,
    this.releaseDate,
    this.createdAt,
    this.updatedAt,
    this.isEnabled,
    this.permissions,
  });

  // Named constructor to initialize from JSON
  RolesListUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    displayName = json['display_name'] as String?;
    aliasName = json['alias_name'] as String?;
    type = json['type'] as String?;
    description = json['description'] as String?;
    version = json['version'] as String?;
    status = json['status'] as String?;
    releaseDate = json['release_date'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    isEnabled = json['is_enabled'] as bool?;

    // Handling the 'permissions' customer_list properly
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      for (var permission in json['permissions']) {
        permissions!.add(Permissions.fromJson(permission as Map<String, dynamic>));
      }
    }
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['display_name'] = displayName;
    data['alias_name'] = aliasName;
    data['type'] = type;
    data['description'] = description;
    data['version'] = version;
    data['status'] = status;
    data['release_date'] = releaseDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_enabled'] = isEnabled;

    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  String? id;
  String? name;
  String? displayName;
  String? description;
  String? createAt;
  String? updatedAt;

  Permissions({
    this.id,
    this.name,
    this.displayName,
    this.description,
    this.createAt,
    this.updatedAt,
  });

  // Named constructor to initialize from JSON
  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    displayName = json['display_name'] as String?;
    description = json['description'] as String?;
    createAt = json['create_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['display_name'] = displayName;
    data['description'] = description;
    data['create_at'] = createAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
