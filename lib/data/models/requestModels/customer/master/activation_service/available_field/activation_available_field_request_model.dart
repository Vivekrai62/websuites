class ActivationAvailableFieldRequestModel {
  final int limit;
  final int page;

  ActivationAvailableFieldRequestModel({
    required this.limit,
    required this.page,
  });

  // Convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'page': page,
    };
  }

  // Create a model from a JSON map (optional, if needed)
  factory ActivationAvailableFieldRequestModel.fromJson(Map<String, dynamic> json) {
    return ActivationAvailableFieldRequestModel(
      limit: json['limit'],
      page: json['page'],
    );
  }
}
