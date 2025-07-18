class DashboardCountResponseModel{
  int? customers;
  int? leads;
  int? orders;
  Revenue? revenue;
  int? unassignedLeads;
  int? repeatedLeads;

  DashboardCountResponseModel({
    this.customers,
    this.leads,
    this.orders,
    this.repeatedLeads,
    this.revenue,
    this.unassignedLeads}
      );

  DashboardCountResponseModel.fromJson(Map<String, dynamic> json) {
    customers = json['customers'];
    leads = json['leads'];
    orders = json['orders'];
    repeatedLeads = json['repeatedLeads'];
    revenue = json['revenue'] != null ? Revenue.fromJson(json['revenue']) : null;
    unassignedLeads = json['unassignedLeads'];
  }

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customers'] = customers;
    data['leads'] = leads;
    data['orders'] = orders;
    data['repeatedLeads'] = repeatedLeads;
    if(revenue != null){
      data['revenue'] = revenue!.toJson();
    }
    data['unassignedLeads'] = unassignedLeads;
    return data;
  }
}

class Revenue{
  int? approved;
  int? pending;
  int? cancel;

  Revenue({this.approved, this.cancel, this.pending});

  Revenue.fromJson(Map<String, dynamic> json) {
    approved = json['approved'];
    pending = json['pending'];
    cancel = json['cancel'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['approved'] = approved;
    data['pending'] = pending;
    data['cancel'] = cancel;
    return data;
  }
}