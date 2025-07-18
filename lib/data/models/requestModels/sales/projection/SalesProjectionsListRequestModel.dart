class SalesProjectionsListRequestModel {
  SalesProjectionsListRequestModel({
    required this.createdBy,
    required this.status,
    required this.dateRange,
    required this.isOpen,
    required this.productCategory,
  });

  final dynamic createdBy;
  final dynamic status;
  final dynamic dateRange;
  final bool? isOpen;
  final dynamic productCategory;

  factory SalesProjectionsListRequestModel.fromJson(Map<String, dynamic> json) {
    return SalesProjectionsListRequestModel(
      createdBy: json["created_by"],
      status: json["status"],
      dateRange: json["date_range"],
      isOpen: json["isOpen"],
      productCategory: json["product_category"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "created_by": createdBy,
      "status": status,
      "date_range": dateRange,
      "isOpen": isOpen,
      "product_category": productCategory,
    };
  }
}