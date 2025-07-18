class UserAddRoleRequestModel {
  UserAddRoleRequestModel({
    required this.name,
    required this.description,
  });

  final String? name;
  final String? description;

  factory UserAddRoleRequestModel.fromJson(Map<String, dynamic> json){
    return UserAddRoleRequestModel(
      name: json["name"],
      description: json["description"],
    );
  }

}
