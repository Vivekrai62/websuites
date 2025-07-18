class LeadUserFilterReqModel {
  LeadUserFilterReqModel({
    required this.userId,
    this.search, // Removed required to allow it to be optional
  });

  final Object? userId; // Changed dynamic to Object?
  final String? search;

  factory LeadUserFilterReqModel.fromJson(Map<String, dynamic> json) {
    return LeadUserFilterReqModel(
      userId: json["userId"],
      search: json["search"] as String?, // Explicitly casting to String?
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "search": search,
    };
  }
}
