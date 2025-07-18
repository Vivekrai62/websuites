class LeadListCountryCodeResponseModel {
  List<CountriesWithPhoneCode>? countriesWithPhoneCode;

  LeadListCountryCodeResponseModel({this.countriesWithPhoneCode});

  LeadListCountryCodeResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['countriesWithPhoneCode'] != null) {
      countriesWithPhoneCode = <CountriesWithPhoneCode>[];
      json['countriesWithPhoneCode'].forEach((v) {
        countriesWithPhoneCode!.add(CountriesWithPhoneCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (countriesWithPhoneCode != null) {
      data['countriesWithPhoneCode'] =
          countriesWithPhoneCode!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountriesWithPhoneCode {
  String? id;
  String? name;
  String? shortName;
  String? phone;

  CountriesWithPhoneCode({this.id, this.name, this.shortName, this.phone});

  CountriesWithPhoneCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['shortName'] = shortName;
    data['phone'] = phone;
    return data;
  }
}
