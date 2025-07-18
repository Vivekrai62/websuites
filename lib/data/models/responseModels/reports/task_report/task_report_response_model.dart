class TaskReportResponseModel {
  TaskReportResponseModel({
     required this.items,
     this.meta,
     this.userKey,
  });

  final List<Item> items;
  final Meta? meta;
  final String? userKey;

  factory TaskReportResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskReportResponseModel(
      items: json["items"] == null
          ? []
          : List<Item>.from(
          (json["items"] as List).map((x) => Item.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      userKey: json["user_key"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "items": items.map((x) => x.toJson()).toList(),
      "meta": meta?.toJson(),
      "user_key": userKey,
    };
  }
}

class Item {
  Item({
     this.user,
     this.email,
    required this.currentTask,
    required this.taskList,
  });

   String? user;
   String? email;
   dynamic currentTask;
  final List<dynamic> taskList;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      user: json["user"],
      email: json["email"],
      currentTask: json["currentTask"],
      taskList: json["taskList"] == null
          ? []
          : List<dynamic>.from(json["taskList"] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user,
      "email": email,
      "currentTask": currentTask,
      "taskList": taskList,
    };
  }
}

class Meta {
  Meta({
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemCount,
  });

  final int currentPage;
  final int itemsPerPage;
  final int totalPages;
  final int totalItems;
  final int itemCount;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json["currentPage"] ?? 0,
      itemsPerPage: json["itemsPerPage"] ?? 0,
      totalPages: json["totalPages"] ?? 0,
      totalItems: json["totalItems"] ?? 0,
      itemCount: json["itemCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "currentPage": currentPage,
      "itemsPerPage": itemsPerPage,
      "totalPages": totalPages,
      "totalItems": totalItems,
      "itemCount": itemCount,
    };
  }
}