class ProductListRequestModel {
  String? brand;
  String? division;
  int limit;
  int page;
  String? productType;
  String search;
  String? status;

  ProductListRequestModel({
    this.brand,
    this.division,
    required this.limit,
    required this.page,
    this.productType,
    required this.search,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'division': division,
      'limit': limit,
      'page': page,
      'product_type': productType,
      'search': search,
      'status': status,
    };
  }

  factory ProductListRequestModel.fromJson(Map<String, dynamic> json) {
    return ProductListRequestModel(
      brand: json['brand'],
      division: json['division'],
      limit: json['limit'] ?? 15,
      page: json['page'] ?? 1,
      productType: json['product_type'],
      search: json['search'] ?? '',
      status: json['status'],
    );
  }
}
