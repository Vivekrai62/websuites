class CustomerMasterFieldCreateRequestModel {
  final String? answers;
  final String fieldLabel;
  final String fieldName;
  final bool required;
  final String type;

  CustomerMasterFieldCreateRequestModel({
    this.answers,
    required this.fieldLabel,
    required this.fieldName,
    required this.required,
    required this.type,
  });

  // Factory method to update an instance from a JSON map
  factory CustomerMasterFieldCreateRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerMasterFieldCreateRequestModel(
      answers: json['answers'],
      fieldLabel: json['field_label'],
      fieldName: json['field_name'],
      required: json['required'],
      type: json['type'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'answers': answers,
      'field_label': fieldLabel,
      'field_name': fieldName,
      'required': required,
      'type': type,
    };
  }
}
