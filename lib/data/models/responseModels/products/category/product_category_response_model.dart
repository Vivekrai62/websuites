class ProductCategoryResponseModel {
  String? id;
  String? name;
  String? description;
  String? image;
  String? createdAt; // Use camelCase for consistency
  String? updatedAt; // Use camelCase for consistency
  Parent? parent;

  ProductCategoryResponseModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.parent,
  });

  ProductCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at']; // Use camelCase
    updatedAt = json['updated_at']; // Use camelCase
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null; // Corrected key
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['created_at'] = createdAt; // Use camelCase
    data['updated_at'] = updatedAt; // Use camelCase
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    return data;
  }
}

class Parent {
  String? id;
  String? name;
  String? description;
  String? image;
  String? createdAt; // Use camelCase for consistency
  String? updatedAt; // Use camelCase for consistency

  Parent({
    this.id,
    this.name,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at']; // Use camelCase
    updatedAt = json['updated_at']; // Use camelCase
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['created_at'] = createdAt; // Use camelCase
    data['updated_at'] = updatedAt; // Use camelCase
    return data;
  }
}