class SalesUpdateProjectionResModel {
  final int? statusCode;
  final String message;

  SalesUpdateProjectionResModel({
    required this.statusCode,
    required this.message,
  });

  factory SalesUpdateProjectionResModel.fromJson(Map<String, dynamic> json) {
    return SalesUpdateProjectionResModel(
      statusCode: json["statusCode"] is int ? json["statusCode"] : null,
      message:
          json["message"] ?? "", // Default to empty string if message is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "message": message,
    };
  }
}
