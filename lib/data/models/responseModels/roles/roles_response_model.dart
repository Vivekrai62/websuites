class RolesResponseModel {
  final String id;
  final String name;
  final String description;
  final bool isDefault;
  final List<User> users;

  RolesResponseModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.isDefault = false,
    this.users = const [],
  });

  factory RolesResponseModel.fromJson(Map<String, dynamic> json) {
    return RolesResponseModel(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
      description: json["description"] ?? '',
      isDefault: json["default"] ?? false,
      users: (json["users"] as List<dynamic>?)
          ?.map((x) => User.fromJson(x))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "default": isDefault,
    "users": users.map((x) => x.toJson()).toList(),
  };
}

class User {
  final String id;
  final String firstName;
  final String lastName;

  User({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? '',
      firstName: json["first_name"] ?? '',
      lastName: json["last_name"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
  };
}