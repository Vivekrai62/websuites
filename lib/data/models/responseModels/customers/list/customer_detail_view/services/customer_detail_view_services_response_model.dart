class CustomerDetailViewServicesResponseModel {
  String? id;
  String? service;
  bool? status;
  String? startDate;
  String? endDate;

  CustomerDetailViewServicesResponseModel(
      {this.id, this.service, this.status, this.startDate, this.endDate});

  CustomerDetailViewServicesResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service'] = service;
    data['status'] = status;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }

  static List<CustomerDetailViewServicesResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => CustomerDetailViewServicesResponseModel.fromJson(json))
        .toList();
  }
}
