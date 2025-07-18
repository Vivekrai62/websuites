class CustomerStatusReportsRequestModel {
  final String? assignedTo;
  final String? customerStatus;
  final bool isFilterUserWithTeam;
  final int limit;
  final int? noOrderForDays;
  final int? noServiceForDays;
  final int page;
  final String? projectStatus;
  final String? serviceRunning;

  CustomerStatusReportsRequestModel({
    this.assignedTo,
    this.customerStatus,
    required this.isFilterUserWithTeam,
    required this.limit,
    this.noOrderForDays,
    this.noServiceForDays,
    required this.page,
    this.projectStatus,
    this.serviceRunning,
  });

  Map<String, dynamic> toJson() {
    return {
      'assignedTo': assignedTo,
      'customer_status': customerStatus,
      'isFilterUserWithTeam': isFilterUserWithTeam,
      'limit': limit,
      'no_order_for_days': noOrderForDays,
      'no_service_for_days': noServiceForDays,
      'page': page,
      'project_status': projectStatus,
      'service_running': serviceRunning,
    };
  }
}
