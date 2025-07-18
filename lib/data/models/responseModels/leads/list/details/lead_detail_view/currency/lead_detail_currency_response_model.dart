class LeadDetailCurrencyResponseModel {
  String? id;
  String? name;
  String? code;
  String? symbol;
  String? createdAt;
  String? updatedAt;

  LeadDetailCurrencyResponseModel(
      {this.id,
      this.name,
      this.code,
      this.symbol,
      this.createdAt,
      this.updatedAt});

  LeadDetailCurrencyResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['symbol'] = symbol;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  static List<LeadDetailCurrencyResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadDetailCurrencyResponseModel.fromJson(json))
        .toList();
  }
}
