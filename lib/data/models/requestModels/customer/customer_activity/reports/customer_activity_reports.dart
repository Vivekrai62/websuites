class CustomerActivityReportsRequestModel {
  final DateTime from;
  final DateTime to;
  final int limit;
  final int page;
  final String? user;

  CustomerActivityReportsRequestModel({
    required this.from,
    required this.to,
    this.limit = 15,
    this.page = 1,
    this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'date_range': {
        'from': from.toIso8601String(),
        'to': to.toIso8601String(),
      },
      'limit': limit,
      'page': page,
      'user': user,
    };
  }

  factory CustomerActivityReportsRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerActivityReportsRequestModel(
      from: DateTime.parse(json['date_range']['from']),
      to: DateTime.parse(json['date_range']['to']),
      limit: json['limit'] ?? 15,
      page: json['page'] ?? 1,
      user: json['user'],
    );
  }
}
