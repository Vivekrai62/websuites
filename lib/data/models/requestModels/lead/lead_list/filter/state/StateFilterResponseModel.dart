import 'package:get/get.dart';

class StateFilterResponseModel {
  String? id;
  String? name;
  String? code;
  String? status;
  String? createdAt;
  String? updatedAt;
  RxBool isSelected; // Add this property

  StateFilterResponseModel({
    this.id,
    this.name,
    this.code,
    this.status,
    this.createdAt,
    this.updatedAt,
    bool? isSelected, // Optional parameter for initialization
  }) : isSelected = (isSelected ?? false).obs; // Initialize with RxBool

  StateFilterResponseModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        code = json['code'],
        status = json['status'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        isSelected = false.obs; // Default to false when creating from JSON

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}