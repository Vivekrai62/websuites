class CustomerServiceAreaResponseModel {
  String? availability;
  int? states;
  String? name;
  String? id;

  CustomerServiceAreaResponseModel(
      {this.availability, this.states, this.name, this.id});

  CustomerServiceAreaResponseModel.fromJson(Map<String, dynamic> json) {
    availability = json['availability'];
    states = json['states'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['availability'] = availability;
    data['states'] = states;
    data['name'] = name;
    data['id'] = id;
    return data;
  }

  static List<CustomerServiceAreaResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerServiceAreaResponseModel.fromJson(json)).toList();
  }
}



