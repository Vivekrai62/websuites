class CustomerMasterActivationSettingRequestModel {
  final int limit;
  final int page;

  CustomerMasterActivationSettingRequestModel({required this.limit, required this.page});

  // Convert the RequestModel to a Map for API request
  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'page': page,
    };
  }
}

