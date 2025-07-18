class UserListRequestModel {
  UserListRequestModel({
    required this.search,
    required this.page,
    required this.limit,
    required this.departmentId,
    required this.roleId,
    required this.status,
  });

  final String? search;
  final int? page;
  final int? limit;
  final dynamic departmentId;
  final dynamic roleId;
  final dynamic status;

  factory UserListRequestModel.fromJson(Map<String, dynamic> json){
    return UserListRequestModel(
      search: json["search"],
      page: json["page"],
      limit: json["limit"],
      departmentId: json["departmentId"],
      roleId: json["roleId"],
      status: json["status"],
    );
  }

}
