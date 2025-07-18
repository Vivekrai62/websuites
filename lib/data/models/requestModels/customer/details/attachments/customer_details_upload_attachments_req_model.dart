class CustomerDetailsAttachmentsUploadReqModel {
  final String file; // Base64 encoded string for binary file
  final String type; // File type (e.g., screenshot)
  final String typeName; // Descriptive name for the file type

  CustomerDetailsAttachmentsUploadReqModel({
    required this.file,
    required this.type,
    required this.typeName,
  });

  // Convert object to JSON map for API request
  Map<String, dynamic> toJson() => {
    'file': file,
    'type': type,
    'typeName': typeName,
  };

  // Create object from JSON map
  factory CustomerDetailsAttachmentsUploadReqModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsAttachmentsUploadReqModel(
      file: json['file'] as String,
      type: json['type'] as String,
      typeName: json['typeName'] as String,
    );
  }
}