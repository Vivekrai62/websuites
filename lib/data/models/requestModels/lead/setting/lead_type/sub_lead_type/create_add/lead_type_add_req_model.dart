class LeadSubTypeAddReqModel {
  String? name;
  bool? isReminderRequired;
  String? type;

  LeadSubTypeAddReqModel({
    this.name,
    this.isReminderRequired,
    this.type,
  });

  factory LeadSubTypeAddReqModel.fromJson(Map<String, dynamic> json) {
    return LeadSubTypeAddReqModel(
      name: json['name'],
      isReminderRequired: json['isReminderRequired'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isReminderRequired': isReminderRequired,
      'type': type,
    };
  }
}
