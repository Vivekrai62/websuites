class CustomerServiceAreaProductResponseModel {
  String? productType;
  String? productCategory;
  String? name;
  String? id;

  CustomerServiceAreaProductResponseModel({this.productType, this.productCategory, this.name, this.id});

  CustomerServiceAreaProductResponseModel.fromJson(Map<String, dynamic> json) {
    productType = json['productType'];
    productCategory = json['productCategory'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productType'] = productType;
    data['productCategory'] = productCategory;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
  static List<CustomerServiceAreaProductResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerServiceAreaProductResponseModel.fromJson(json)).toList();
  }

}