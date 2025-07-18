class PinCodeCityModelResModel {
  String? id;
  String? name;
  State? state;

  PinCodeCityModelResModel({this.id, this.name, this.state});

  /// Constructor to create an object from JSON
  PinCodeCityModelResModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'] != null ? State.fromJson(json['state']) : null;
  }

  /// Convert the object to JSON format
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    if (state != null) {
      data['state'] = state!.toJson();
    }
    return data;
  }

  /// Static method to parse a list of JSON objects
  static List<PinCodeCityModelResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => PinCodeCityModelResModel.fromJson(json))
        .toList();
  }
}

class State {
  String? id;
  String? name;
  Country? country;

  State({this.id, this.name, this.country});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    return data;
  }
}

class Country {
  String? id;
  String? name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
