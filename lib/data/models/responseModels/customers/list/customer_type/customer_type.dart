class CustomerTypeResponseModel {
  String? id;
  String? name;
  bool? status;
  String? createdAt;
  String? updatedAt;
  List<Children>? children;

  CustomerTypeResponseModel({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.children,
  });

  CustomerTypeResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    status = json['status'] as bool?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  static List<CustomerTypeResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerTypeResponseModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? id;
  String? name;
  bool? status;
  String? createdAt;
  String? updatedAt;

  Children({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    status = json['status'] as bool?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
