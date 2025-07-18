class CitySearchRequestModel {
  String? search;

  CitySearchRequestModel({this.search});

  CitySearchRequestModel.fromJson(Map<String, dynamic> json) {
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    return data;
  }
}
