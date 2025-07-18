class DashboardLeadSourceRequestModel{
String? id;
String? name;
String? status;
String? createdAt;
String? updateAt;
String? leads;
int? leadCount;

DashboardLeadSourceRequestModel({
  this.id,
  this.name,
  this.status,
  this.createdAt,
  this.updateAt,
  this.leads,
  this.leadCount,
});

Map toJson() => {
  'id': id,
  'name': name,
  'status': status,
  'created_at': createdAt,
  'updated_at': updateAt,
  'leads': leads,
  'leadCount': leadCount,
};}