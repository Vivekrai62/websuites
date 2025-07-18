class CustomerMasterFieldResponseModel {
  List<Items>? items;
  Meta? meta;

  CustomerMasterFieldResponseModel({this.items, this.meta});

  CustomerMasterFieldResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Items {
  String? id;
  String? field_label;
  String? field_name;
  String? type;
  String? answers;
  bool? required;
  bool? isdefault;
  String? created_at;
  String? updated_at;

  Items(
      {this.id,
      this.field_label,
      this.field_name,
      this.type,
      this.answers,
      this.required,
      this.isdefault,
      this.created_at,
      this.updated_at});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    field_label = json['field_label'];
    field_name = json['field_name'];
    type = json['type'];
    answers = json['answers'];
    required = json['required'];
    isdefault = json['default'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['field_label'] = field_label;
    data['field_name'] = field_name;
    data['type'] = type;
    data['answers'] = answers;
    data['required'] = required;
    data['default'] = isdefault;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? itemsPerPage;
  int? totalPages;
  int? totalItems;
  int? itemCount;

  Meta(
      {this.currentPage,
      this.itemsPerPage,
      this.totalPages,
      this.totalItems,
      this.itemCount});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    itemsPerPage = json['itemsPerPage'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['itemsPerPage'] = itemsPerPage;
    data['totalPages'] = totalPages;
    data['totalItems'] = totalItems;
    data['itemCount'] = itemCount;
    return data;
  }
}
