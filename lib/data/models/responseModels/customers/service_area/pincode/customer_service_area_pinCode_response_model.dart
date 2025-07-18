
class CustomerServiceAreaPinCodeResponseModel {
  String? availability;
  int? pinCodes;
  String? code;
  String? id;

  CustomerServiceAreaPinCodeResponseModel(
      {this.availability, this.pinCodes, this.code, this.id});

  CustomerServiceAreaPinCodeResponseModel.fromJson(Map<String, dynamic> json) {
    availability = json['availability'];
    pinCodes = json['pincodes'];
    code = json['code'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['availability'] = availability;
    data['pincodes'] = pinCodes;
    data['code'] = code;
    data['id'] = id;
    return data;
  }
  static List<CustomerServiceAreaPinCodeResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerServiceAreaPinCodeResponseModel.fromJson(json)).toList();
  }
}

