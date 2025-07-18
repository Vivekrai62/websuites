class AddGstResponseModel {
  int? status;
  int? igst;
  int? cgst;
  int? sgst;
  String? name;
  String? id;
  String? createdAt;
  String? updatedAt;

  AddGstResponseModel(
      {this.status,
      this.igst,
      this.cgst,
      this.sgst,
      this.name,
      this.id,
      this.createdAt,
      this.updatedAt});

  AddGstResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    igst = json['igst'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    name = json['name'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['igst'] = igst;
    data['cgst'] = cgst;
    data['sgst'] = sgst;
    data['name'] = name;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
