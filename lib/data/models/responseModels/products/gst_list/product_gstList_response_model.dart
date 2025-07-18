class ProductGstListResponseModel {
  String? id;
  String? name;
  int? sgst;
  int? cgst;
  int? igst;
  int? status;
  String? created_at;
  String? updated_at;

  ProductGstListResponseModel({
    this.id,
    this.name,
    this.sgst,
    this.cgst,
    this.igst,
    this.status,
    this.updated_at,
    this.created_at
});

  ProductGstListResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sgst = json['sgst'];
    cgst = json['cgst'];
    igst = json['igst'];
    status = json['status'];
    updated_at = json['updated_at'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['name'] = name;
    data['sgst'] = sgst;
    data['cgst'] = cgst;
    data['igst'] = igst;
    data['status'] = status;
    data['updated_at'] = updated_at;
    data['created_at'] = created_at;
    return data;
  }

  static List<ProductGstListResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) =>ProductGstListResponseModel.fromJson(json)).toList();
  }
}