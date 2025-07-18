class ProjectRequestModel {
  final String? activation;
  final String? billingType;
  final String? company;
  final String? customer;
  final String? deadline;
  final String? demoUrl;
  final String? description;
  final int? estimatedHours;
  final String? liveUrl;
  final List<String>? members;
  final String? projectName;
  final String? startDate;
  final String? status;
  final List<String>? tags;
  final int? totalRate;

  ProjectRequestModel({
    this.activation,
    this.billingType,
    this.company,
    this.customer,
    this.deadline,
    this.demoUrl,
    this.description,
    this.estimatedHours,
    this.liveUrl,
    this.members,
    this.projectName,
    this.startDate,
    this.status,
    this.tags,
    this.totalRate,
  });

  Map<String, dynamic> toJson() {
    return {
      'activation': activation,
      'billing_type': billingType,
      'company': company,
      'customer': customer,
      'deadline': deadline,
      'demo_url': demoUrl,
      'description': description,
      'estimated_hours': estimatedHours,
      'live_url': liveUrl,
      'members': members,
      'project_name': projectName,
      'start_date': startDate,
      'status': status,
      'tags': tags,
      'total_rate': totalRate,
    };
  }
}
