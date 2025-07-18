class CustomerTypeCreateRequestModel {
  String? name;
  bool? status;

  CustomerTypeCreateRequestModel({this.name, this.status});

  // Convert JSON to RequestModel
  factory CustomerTypeCreateRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerTypeCreateRequestModel(
      name: json['name'],
      status: json['status'],
    );
  }

  // Convert RequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
    };
  }
}
