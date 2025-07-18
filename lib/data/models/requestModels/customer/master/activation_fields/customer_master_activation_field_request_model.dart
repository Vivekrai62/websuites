class CustomerMasterActivationFieldRequestModel {
  final int limit;
  final int page;
  final String search;

  CustomerMasterActivationFieldRequestModel({
    required this.limit,
    required this.page,
    required this.search,
  });

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'page': page,
      'search': search,
    };
  }

  // Deserialize JSON into the model
  factory CustomerMasterActivationFieldRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerMasterActivationFieldRequestModel(
      limit: json['limit'] ?? 0,
      page: json['page'] ?? 1,
      search: json['search'] ?? '',
    );
  }
}
