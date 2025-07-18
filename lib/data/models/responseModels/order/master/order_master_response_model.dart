class OrderMasterResponseModel {
  String? id;
  String? name;
  String? color;
  bool? isdefault;
  String? created_at;
  String? updated_at;

  OrderMasterResponseModel({
    this.id,
    this.name,
    this.color,
    this.isdefault,
    this.updated_at,
    this.created_at
});

  OrderMasterResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    isdefault = json['isdefault'];
    updated_at = json['updated_at'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    data['isdefault'] = isdefault;
    data['updated_at'] = updated_at;
    data['created_at'] = created_at;
    return data;
  }
}