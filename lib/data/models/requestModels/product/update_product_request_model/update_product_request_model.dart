class UpdateProductRequestModel {
  String? brand;
  String description;
  String? division;
  String downloadLink;
  int duration;
  double? gst;
  bool isTaxable;
  String name;
  List<dynamic>? otherPrices;
  String packing;
  List<String>? productCategory;
  String productType;
  bool projectActivationDisabled;
  int quantity;
  bool status;

  UpdateProductRequestModel({
    this.brand,
    required this.description,
    this.division,
    required this.downloadLink,
    required this.duration,
    this.gst,
    required this.isTaxable,
    required this.name,
    this.otherPrices,
    required this.packing,
    this.productCategory,
    required this.productType,
    required this.projectActivationDisabled,
    required this.quantity,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'description': description,
      'division': division,
      'download_link': downloadLink,
      'duration': duration,
      'gst': gst,
      'is_taxable': isTaxable,
      'name': name,
      'otherPrices': otherPrices,
      'packing': packing,
      'product_category': productCategory,
      'product_type': productType,
      'project_activation_disabled': projectActivationDisabled,
      'quantity': quantity,
      'status': status,
    };
  }

  factory UpdateProductRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateProductRequestModel(
      brand: json['brand'],
      description: json['description'] ?? '',
      division: json['division'],
      downloadLink: json['download_link'] ?? '',
      duration: json['duration'] ?? 0,
      gst: json['gst']?.toDouble(),
      isTaxable: json['is_taxable'] ?? false,
      name: json['name'] ?? '',
      otherPrices: json['otherPrices'],
      packing: json['packing'] ?? '',
      productCategory: (json['product_category'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      productType: json['product_type'] ?? '',
      projectActivationDisabled: json['project_activation_disabled'] ?? false,
      quantity: json['quantity'] ?? 1,
      status: json['status'] ?? true,
    );
  }
}
