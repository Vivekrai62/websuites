class LeadAssignedToSalesReqModel {
  List<String>? leads;

  LeadAssignedToSalesReqModel({this.leads});

  LeadAssignedToSalesReqModel.fromJson(Map<String, dynamic> json) {
    leads = json['leads'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leads'] = this.leads;
    return data;
  }
}
