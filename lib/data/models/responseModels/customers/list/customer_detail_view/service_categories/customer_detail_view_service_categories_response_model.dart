class CustomerListServiceCategoriesResponseModel {
  String? image;
  String? category;
  String? product;
  String? categoryId;
  String? productId;

  CustomerListServiceCategoriesResponseModel(
      {this.image,
      this.category,
      this.product,
      this.categoryId,
      this.productId});

  CustomerListServiceCategoriesResponseModel.fromJson(
      Map<String, dynamic> json) {
    image = json['image'];
    category = json['category'];
    product = json['product'];
    categoryId = json['categoryId'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['category'] = category;
    data['product'] = product;
    data['categoryId'] = categoryId;
    data['productId'] = productId;
    return data;
  }

  static List<CustomerListServiceCategoriesResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map(
            (json) => CustomerListServiceCategoriesResponseModel.fromJson(json))
        .toList();
  }
}
