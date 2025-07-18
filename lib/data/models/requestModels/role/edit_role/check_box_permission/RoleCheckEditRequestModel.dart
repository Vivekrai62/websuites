// RoleEditCheckRequestModel.dart

class RoleEditCheckRequestModel {
  String? permission;

  RoleEditCheckRequestModel({this.permission});

  // From JSON to request model
  factory RoleEditCheckRequestModel.fromJson(Map<String, dynamic> json) {
    return RoleEditCheckRequestModel(
      permission: json['permission'],
    );
  }

  // From request model to JSON
  Map<String, dynamic> toJson() {
    return {
      'permission': permission,
    };
  }
}
