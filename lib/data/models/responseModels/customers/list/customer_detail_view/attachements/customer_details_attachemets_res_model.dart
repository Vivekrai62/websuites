class CustomerDetailsAttachments {
  String? id;
  String? type;
  String? filename;
  String? typeName;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  CustomerDetailsAttachments({
    this.id,
    this.type,
    this.filename,
    this.typeName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory CustomerDetailsAttachments.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsAttachments(
      id: json['id'] as String?,
      type: json['type'] as String?,
      filename: json['filename'] as String?,
      typeName: json['type_name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }

  static List<CustomerDetailsAttachments> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerDetailsAttachments.fromJson(json as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'filename': filename,
      'type_name': typeName,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}