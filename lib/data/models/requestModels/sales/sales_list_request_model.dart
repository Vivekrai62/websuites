class SalesListRequestModel {
  final int limit;
  final int page;

  SalesListRequestModel({required this.limit, required this.page});

  // Converts the model to a Map for use in API calls
  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'page': page,
    };
  }

  // Creates a model from a JSON response (optional, if needed)
  factory SalesListRequestModel.fromJson(Map<String, dynamic> json) {
    return SalesListRequestModel(
      limit: json['limit'],
      page: json['page'],
    );
  }
}
