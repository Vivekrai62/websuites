class LeadMastersStatusResponseModel {
  String? id;
  String? name;
  String? reference;
  String? description;
  String? status;
  bool? isdefault;
  int? order;
  String? created_at;
  String? updated_at;

  LeadMastersStatusResponseModel({
    this.id,
    this.name,
    this.reference,
    this.description,
    this.status,
    this.isdefault,
    this.order,
    this.created_at,
    this.updated_at
});

  LeadMastersStatusResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    reference = json['reference'];
    description = json['description'];
    status = json['status'];
    isdefault = json['isdefault'];
    order = json['order'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['name'] = name;
    data['reference'] = reference;
    data['description'] = description;
    data['status'] = status;
    data['isdefault'] = isdefault;
    data['order'] = order;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    return data;
  }
}