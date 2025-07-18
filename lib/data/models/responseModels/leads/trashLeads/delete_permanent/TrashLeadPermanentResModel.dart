class TrashLeadPermanent {
  final String message;
  final bool success;

  TrashLeadPermanent({
    required this.message,
    required this.success,
  });

  factory TrashLeadPermanent.fromJson(Map<String, dynamic> json) {
    return TrashLeadPermanent(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
    };
  }
}
