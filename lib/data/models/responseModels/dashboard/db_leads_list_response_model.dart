// class DashboardLeadsListResponseModelCheck{
//   List<Items>? items;
//   Meta? meta;
//   Null user_key;
//
//   DashboardLeadsListResponseModelCheck({
//     this.items,
//     this.meta,
//     this.user_key
// });
//
//
//   DashboardLeadsListResponseModelCheck.fromJson(Map<String, dynamic> json){
//     if (json['items'] != null){
//       items = <Items>[];
//       json['items'].forEach((v) {
//         items!.add(Items.fromJson(v));
//       });
//     }
//     meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
//     user_key = json['user_key'];
//   }
//
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (items != null) {
//       data['items'] = items!.map((v) => v.toJson()).toList();
//     }
//     if (meta != null) {
//       data['meta'] = meta!.toJson();
//     }
//     data['user_key'] = user_key;
//     return data;
//   }
// }
//
// class Items{
//   String? id;
//   Null first_name;
//   Null last_name;
//   int? country_code;
//   int? mobile;
//   Null organization;
//   String? created_at;
//   String? updated_at;
//   int? latest_enquiry_date;
//   Null lead_parent;
//   List<Null>? enquiries;
//   List<LeadAssigned>? lead_assigned;
//   Source? source;
//   List<Divisions>? divisions;
//   List<Null>? products;
//   Last_Activity? last_activity;
//   List<Null>? lead_activities;
//
//
//   Items({
//     this.id,
//     this.first_name,
//     this.last_name,
//     this.country_code,
//     this.mobile,
//     this.organization,
//     this.created_at,
//     this.updated_at,
//     this.latest_enquiry_date,
//     this.lead_parent,
//     this.enquiries,
//     this.lead_assigned,
//     this.source,
//     this.products,
//     this.last_activity,
//     this.lead_activities
//   });
//
//   Items.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     first_name = json['first_name'];
//     last_name = json['last_name'];
//     country_code = json['country_code'];
//     mobile = json['mobile'];
//     organization = json['organization'];
//     created_at = json['created_at'];
//     updated_at = json['updated_at'];
//     latest_enquiry_date = json['latest_enquiry_date'];
//     lead_parent = json['lead_parent'];
//     if(json['enquiries'] != null){
//       enquiries = <Null>[];
//       json['enquiries'].forEach((v) {
//         enquiries!.add(Null.fromJson(v));
//       });
//     }
//     if(json['lead_assigned'] != null){
//       lead_assigned = <LeadAssigned>[];
//       json['lead_assigned'].forEach((v) {
//         lead_assigned!.add(LeadAssigned.fromJson(v));
//       });
//     }
//
//     if(json['divisions'] != null) {
//       divisions = <Divisions> [];
//       json['divisions'].forEach((v){
//         divisions!.add(Divisions.fromJson(v));
//       });
//     }
//     source = json['source'] != null ? Source.fromJson(json['source']) : null;
//     if(json['products'] != null){
//       products = <Null>[];
//       json['products'].forEach((v){
//         products!.add(Null.fromJson(v));
//       });
//     }
//     last_activity = json['last_activity'] != null ? Last_Activity.fromJson(json['last_activity']) : null;
//     if(json['lead_activities'] != null){
//       lead_activities = <Null>[];
//       json['lead_activities'].forEach((v){
//         lead_activities!.add(Null.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson(){
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['first_name'] = first_name;
//     data['last_name'] = last_name;
//     data['country_code'] = country_code;
//     data['mobile'] = mobile;
//     data['organization'] = organization;
//     data['created_at'] = created_at;
//     data['updated_at'] = updated_at;
//     data['latest_enquiry_date'] = latest_enquiry_date;
//     data['lead_parent'] = lead_parent;
//     if (enquiries != null) {
//       data['enquiries'] =
//           enquiries!.map((v) => v.toJson()).toList();
//     }
//     if(lead_assigned != null) {
//       data['lead_assigned'] = lead_assigned !.map((v) => v.toJson()).toList();
//     }
//
//     if(source != null) {
//       data['source'] = source?.toJson();
//     }
//
//     if(divisions != null) {
//       data['divisions'] = divisions!.map((v) => v.toJson()).toList();
//     }
//
//     if(products != null) {
//       data['products'] = products !.map((v) => v.toJson()).toList();
//     }
//
//     if (last_activity != null) {
//       data['last_activity'] = last_activity!.toJson();
//     }
//     if (lead_activities != null) {
//       data['lead_activities'] =
//           lead_activities!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Divisions {
//   String? id;
//   String? name;
//
//   Divisions ({
//     this.name,
//     this.id
// });
//
//   Divisions.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson (){
//     final Map<String, dynamic> data = <String, dynamic> {};
//     data['id'] = id;
//     data['name'] = name;
//     return data;
//   }
// }
//
// class LeadAssigned {
//   String? id;
//   int? status;
//   String? created_at;
//   User? user;
//
//   LeadAssigned({this.id, this.status, this.created_at, this.user});
//
//   LeadAssigned.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     status = json['status'];
//     created_at = json['created_at'];
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['status'] = status;
//     data['created_at'] = created_at;
//     if (user != null) {
//       data['user'] = user!.toJson();
//     }
//     return data;
//   }
// }
//
// class User{
//   String? id;
//   String? first_name;
//   String? last_name;
//
//   User({
//     this.id,
//     this.first_name,
//     this.last_name,
//   });
//
//   User.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     first_name = json['first_name'];
//     last_name = json['last_name'];
//   }
//
//   Map<String, dynamic> toJson (){
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['first_name'] = id;
//     data['last_name'] = id;
//     return data;
//   }
// }
//
// class Source{
//   String? id;
//   String? name;
//
//   Source({
//     this.id,
//     this.name,
// });
//
//   Source.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson (){
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     return data;
//   }
// }
//
// class Last_Activity {
//   String? id;
//   String? activity;
//   String? remark;
//   Null reminder;
//   bool? reminder_status;
//   Null meeting_with;
//   Null meeting_with_name;
//   Null meeting_with_phone;
//   Null date_contacted;
//   String? services;
//   double? lat;
//   double? lng;
//   Null cc_to;
//   bool? informed_to_customer;
//   Null remote_location;
//   String? created_at;
//   String? updated_at;
//   Null deleted_at;
//   int? call_duration;
//   Null record_file;
//   Null call_activity_description;
//
//   Last_Activity({
//     this.id,
//     this.activity,
//     this.remark,
//     this.reminder,
//     this.reminder_status,
//     this.meeting_with,
//     this.meeting_with_name,
//     this.meeting_with_phone,
//     this.date_contacted,
//     this.services,
//     this.lat,
//     this.lng,
//     this.cc_to,
//     this.informed_to_customer,
//     this.remote_location,
//     this.created_at,
//     this.updated_at,
//     this.deleted_at,
//     this.call_duration,
//     this.record_file,
//     this.call_activity_description
//   });
//
//   Last_Activity.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     activity = json['activity'];
//     remark = json['remark'];
//     reminder = json['reminder'];
//     reminder_status = json['reminder_status'];
//     meeting_with = json['meeting_with'];
//     meeting_with_name = json['meeting_with_name'];
//     meeting_with_phone = json['meeting_with_phone'];
//     date_contacted = json['date_contacted'];
//     services = json['services'];
//     lat = json['lat'];
//     lng = json['lng'];
//     cc_to = json['cc_to'];
//     informed_to_customer = json['informed_to_customer'];
//     remote_location = json['remote_location'];
//     created_at = json['created_at'];
//     updated_at = json['updated_at'];
//     deleted_at = json['deleted_at'];
//     call_duration = json['call_duration'];
//     record_file = json['record_file'];
//     call_activity_description = json['call_activity_description'];
//   }
//
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['activity'] = activity;
//     data['remark'] = remark;
//     data['reminder'] = reminder;
//     data['reminder_status'] = reminder_status;
//     data['meeting_with'] = meeting_with;
//     data['meeting_with_name'] = meeting_with_name;
//     data['meeting_with_phone'] = meeting_with_phone;
//     data['date_contacted'] = date_contacted;
//     data['services'] = services;
//     data['lat'] = lat;
//     data['lng'] = lng;
//     data['cc_to'] = cc_to;
//     data['informed_to_customer'] = informed_to_customer;
//     data['remote_location'] = remote_location;
//     data['created_at'] = created_at;
//     data['updated_at'] = updated_at;
//     data['deleted_at'] = deleted_at;
//     data['call_duration'] = call_duration;
//     data['record_file'] = record_file;
//     data['call_activity_description'] = call_activity_description;
//     return data;
//   }
// }
//
// class Meta{
//   int? currentPage;
//   int? itemsPerPage;
//   int? totalPages;
//   int? totalItems;
//   int? itemCount;
//
//   Meta({
//     this.currentPage,
//     this.itemsPerPage,
//     this.totalPages,
//     this.totalItems,
//     this.itemCount
//   });
//   Meta.fromJson(Map<String, dynamic> json) {
//     currentPage = json['currentPage'];
//     itemsPerPage = json['itemsPerPage'];
//     totalPages = json['totalPages'];
//     totalItems = json['totalItems'];
//     itemCount = json['itemCount'];
//   }
//
//   Map<String, dynamic> toJson (){
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['currentPage'] = currentPage;
//     data['itemsPerPage'] = itemsPerPage;
//     data['totalPages'] = totalPages;
//     data['totalItems'] = totalItems;
//     data['itemCount'] = itemCount;
//     return data;
//   }
// }
//
