class SettingsResponseModel {
  String? id;
  String? leadField;
  String? fieldName;
  int? order;
  bool? filter;
  bool? allowGlobalSearch;
  bool? status;
  String? type;
  String? createdAt;
  String? updatedAt;
  List<ViewPermissions>? viewPermissions;
  List<EditPermissions>? editPermissions;

  SettingsResponseModel(
      {this.id,
        this.leadField,
        this.fieldName,
        this.order,
        this.filter,
        this.allowGlobalSearch,
        this.status,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.viewPermissions,
        this.editPermissions,
      });

  SettingsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadField = json['lead_field'];
    fieldName = json['field_name'];
    order = json['order'];
    filter = json['filter'];
    allowGlobalSearch = json['allowGlobalSearch'];
    status = json['status'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['viewPermissions'] != null) {
      viewPermissions = <ViewPermissions>[];
      json['viewPermissions'].forEach((v) {
        viewPermissions!.add(ViewPermissions.fromJson(v));
      });
    }
    if (json['editPermissions'] != null) {
      editPermissions = <EditPermissions>[];
      json['editPermissions'].forEach((v) {
        editPermissions!.add(EditPermissions.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lead_field'] = leadField;
    data['field_name'] = fieldName;
    data['order'] = order;
    data['filter'] = filter;
    data['allowGlobalSearch'] = allowGlobalSearch;
    data['status'] = status;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (viewPermissions != null) {
      data['viewPermissions'] =
          viewPermissions!.map((v) => v.toJson()).toList();
    }
    if (editPermissions != null) {
      data['editPermissions'] =
          editPermissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EditPermissions {
  String? id;
  String? name;

  EditPermissions({this.name, this.id});

  EditPermissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

}

class ViewPermissions {
  String? id;
  String? name;

  ViewPermissions({this.id, this.name});

  ViewPermissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

