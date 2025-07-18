class ProductsServicesReqModel {
  String? search;
  bool? status;
  int? page;
  int? limit;
  String? brand;
  String? division;
  String? serviceType;

  ProductsServicesReqModel(
      {this.search,
      this.status,
      this.page,
      this.limit,
      this.brand,
      this.division,
      this.serviceType});

  ProductsServicesReqModel.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    status = json['status'];
    page = json['page'];
    limit = json['limit'];
    brand = json['brand'];
    division = json['division'];
    serviceType = json['service_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    data['status'] = status;
    data['page'] = page;
    data['limit'] = limit;
    data['brand'] = brand;
    data['division'] = division;
    data['service_type'] = serviceType;
    return data;
  }
}
