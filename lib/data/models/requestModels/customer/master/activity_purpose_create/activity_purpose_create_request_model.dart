class ActivityPurposeCreateRequestModel {
  String name;
  bool status;
  String type;

  ActivityPurposeCreateRequestModel({
    required this.name,
    required this.status,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
      'type': type,
    };
  }
}
