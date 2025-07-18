class CustomerServiceAreaCityResponseModel {
  String? availability;
  int? districts;
  String? name;
  String? id;


  CustomerServiceAreaCityResponseModel(
      {this.availability, this.districts, this.name, this.id});

  CustomerServiceAreaCityResponseModel.fromJson(Map<String, dynamic> json) {
    availability = json['availability'];
    districts = json['districts'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['availability'] = availability;
    data['districts'] = districts;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
  static List<CustomerServiceAreaCityResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerServiceAreaCityResponseModel.fromJson(json)).toList();
  }
}