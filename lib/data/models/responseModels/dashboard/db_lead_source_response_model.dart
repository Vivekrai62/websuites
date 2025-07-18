class DashboardLeadSourceResponseModel{
  String? id;
  String? name;
  String? status;
  String? created_at;
  String? update_at;
  String? leads;
  int? leadCount;

  DashboardLeadSourceResponseModel({
    this.id,
    this.name,
    this.status,
    this.created_at,
    this.update_at,
    this.leads,
    this.leadCount
});

  DashboardLeadSourceResponseModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    status = json['status'];
    created_at = json['created_at'];
    update_at = json['updated_at'];
    leads = json['leads'];
    leadCount = json['leadCount'];
  }

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = created_at;
    data['updated_at'] = update_at;
    data['leads'] = leads;
    data['leadCount'] = leadCount;
    return data;
  }
}