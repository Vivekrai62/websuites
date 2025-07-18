class DivisionsResponseModel {
  String? id;
  String? name;
  String? status;
  String? created_at;

  DivisionsResponseModel ({
    this.id,
    this.name,
    this.status,
    this.created_at
});

  DivisionsResponseModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    status = json['status'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = created_at;
    return data;
  }
}