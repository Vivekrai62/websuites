class NotificationResModel {
  final List<Items> items;
  final Meta meta;

  NotificationResModel({this.items = const [], this.meta = const Meta()});

  factory NotificationResModel.fromJson(Map<String, dynamic> json) {
    return NotificationResModel(
      items: (json['items'] as List<dynamic>?)
              ?.map((v) => Items.fromJson(v as Map<String, dynamic>))
              .toList() ??
          [],
      meta: json['meta'] != null
          ? Meta.fromJson(json['meta'] as Map<String, dynamic>)
          : const Meta(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((v) => v.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

class Items {
  final String id;
  final String message;
  final String status;
  final String? link;
  final String? data;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final Title? title;

  Items({
    required this.id,
    required this.message,
    required this.status,
    this.link,
    this.data,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.title,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'] as String? ?? '',
      message: json['message'] as String? ?? '',
      status: json['status'] as String? ?? '',
      link: json['link'] as String?,
      data: json['data'] as String?,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      deletedAt: json['deleted_at'] as String?,
      title: json['title'] != null
          ? Title.fromJson(json['title'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'status': status,
      'link': link,
      'data': data,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      if (title != null) 'title': title!.toJson(),
    };
  }
}

class Title {
  final String id;
  final String name;
  final String? icon;
  final String? color;

  Title({
    required this.id,
    required this.name,
    this.icon,
    this.color,
  });

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String?,
      color: json['color'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
    };
  }
}

class Meta {
  final int unreadCount;
  final int currentPage;
  final int itemsPerPage;
  final int totalPages;
  final int totalItems;
  final int itemCount;

  const Meta({
    this.unreadCount = 0,
    this.currentPage = 0,
    this.itemsPerPage = 0,
    this.totalPages = 0,
    this.totalItems = 0,
    this.itemCount = 0,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      unreadCount: json['unreadCount'] as int? ?? 0,
      currentPage: json['currentPage'] as int? ?? 0,
      itemsPerPage: json['itemsPerPage'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      totalItems: json['totalItems'] as int? ?? 0,
      itemCount: json['itemCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unreadCount': unreadCount,
      'currentPage': currentPage,
      'itemsPerPage': itemsPerPage,
      'totalPages': totalPages,
      'totalItems': totalItems,
      'itemCount': itemCount,
    };
  }
}
