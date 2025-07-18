class ServiceAreaCityRequestModel {
  final String divisionId;
  final String stateId;

  ServiceAreaCityRequestModel({
    required this.divisionId,
    required this.stateId,
  });

  // Convert the model to JSON format
  Map<String, dynamic> toJson() {
    return {
      'divisionId': divisionId,
      'stateId': stateId,
    };
  }
}

