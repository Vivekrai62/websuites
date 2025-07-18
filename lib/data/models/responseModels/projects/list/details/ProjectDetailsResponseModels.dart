class ProjectDetailResponseModel {
  ProjectDetailResponseModel({
    required this.project,
    required this.sendEmailDetail,
    required this.users,
    required this.tasks,
    required this.sentActivation,
  });

  final Project? project;
  final SendEmailDetail? sendEmailDetail;
  final List<dynamic> users;
  final Tasks? tasks;
  final dynamic sentActivation;

  factory ProjectDetailResponseModel.fromJson(Map<String, dynamic> json){
    return ProjectDetailResponseModel(
      project: json["project"] == null ? null : Project.fromJson(json["project"]),
      sendEmailDetail: json["sendEmailDetail"] == null ? null : SendEmailDetail.fromJson(json["sendEmailDetail"]),
      users: json["users"] == null ? [] : List<dynamic>.from(json["users"]!.map((x) => x)),
      tasks: json["tasks"] == null ? null : Tasks.fromJson(json["tasks"]),
      sentActivation: json["sentActivation"],
    );
  }

}

class Project {
  Project({
    required this.id,
    required this.projectName,
    required this.billingType,
    required this.status,
    required this.totalRate,
    required this.estimatedHours,
    required this.startDate,
    required this.deadline,
    required this.description,
    required this.demoUrl,
    required this.finishDate,
    required this.liveUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
    required this.members,
    required this.company,
    required this.tags,
    required this.projectReportReminders,
    required this.projectReport,
  });

  final String? id;
  final String? projectName;
  final String? billingType;
  final String? status;
  final int? totalRate;
  final int? estimatedHours;
  final DateTime? startDate;
  final DateTime? deadline;
  final String? description;
  final String? demoUrl;
  final dynamic finishDate;
  final String? liveUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Customer? customer;
  final List<Customer> members;
  final Company? company;
  final List<Tag> tags;
  final List<dynamic> projectReportReminders;
  final List<dynamic> projectReport;

  factory Project.fromJson(Map<String, dynamic> json){
    return Project(
      id: json["id"],
      projectName: json["project_name"],
      billingType: json["billing_type"],
      status: json["status"],
      totalRate: json["total_rate"],
      estimatedHours: json["estimated_hours"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      deadline: DateTime.tryParse(json["deadline"] ?? ""),
      description: json["description"],
      demoUrl: json["demo_url"],
      finishDate: json["finish_date"],
      liveUrl: json["live_url"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
      members: json["members"] == null ? [] : List<Customer>.from(json["members"]!.map((x) => Customer.fromJson(x))),
      company: json["company"] == null ? null : Company.fromJson(json["company"]),
      tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
      projectReportReminders: json["project_report_reminders"] == null ? [] : List<dynamic>.from(json["project_report_reminders"]!.map((x) => x)),
      projectReport: json["project_report"] == null ? [] : List<dynamic>.from(json["project_report"]!.map((x) => x)),
    );
  }

}

class Company {
  Company({
    required this.id,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.countryCode,
    required this.contactPersonName,
    required this.contactPersonNumber,
    required this.cCountryCode,
    required this.website,
    required this.logo,
  });

  final String? id;
  final String? companyName;
  final String? companyEmail;
  final String? companyPhone;
  final int? countryCode;
  final String? contactPersonName;
  final String? contactPersonNumber;
  final int? cCountryCode;
  final dynamic website;
  final dynamic logo;

  factory Company.fromJson(Map<String, dynamic> json){
    return Company(
      id: json["id"],
      companyName: json["company_name"],
      companyEmail: json["company_email"],
      companyPhone: json["company_phone"],
      countryCode: json["country_code"],
      contactPersonName: json["contact_person_name"],
      contactPersonNumber: json["contact_person_number"],
      cCountryCode: json["c_country_code"],
      website: json["website"],
      logo: json["logo"],
    );
  }

}

class Customer {
  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final dynamic profilePic;

  factory Customer.fromJson(Map<String, dynamic> json){
    return Customer(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      profilePic: json["profile_pic"],
    );
  }

}

class Tag {
  Tag({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Tag.fromJson(Map<String, dynamic> json){
    return Tag(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class SendEmailDetail {
  SendEmailDetail({
    required this.ccto,
  });

  final List<String> ccto;

  factory SendEmailDetail.fromJson(Map<String, dynamic> json){
    return SendEmailDetail(
      ccto: json["ccto"] == null ? [] : List<String>.from(json["ccto"]!.map((x) => x)),
    );
  }

}

class Tasks {
  Tasks({
    required this.standard,
    required this.others,
  });

  final List<Standard> standard;
  final Others? others;

  factory Tasks.fromJson(Map<String, dynamic> json){
    return Tasks(
      standard: json["standard"] == null ? [] : List<Standard>.from(json["standard"]!.map((x) => Standard.fromJson(x))),
      others: json["others"] == null ? null : Others.fromJson(json["others"]),
    );
  }

}

class Others {
  Others({
    required this.count,
    required this.tasks,
  });

  final int? count;
  final List<Standard> tasks;

  factory Others.fromJson(Map<String, dynamic> json){
    return Others(
      count: json["count"],
      tasks: json["tasks"] == null ? [] : List<Standard>.from(json["tasks"]!.map((x) => Standard.fromJson(x))),
    );
  }

}

class Standard {
  Standard({
    required this.statusId,
    required this.statusName,
    required this.statusReference,
    required this.statusColor,
    required this.tasks,
  });

  final String? statusId;
  final String? statusName;
  final String? statusReference;
  final String? statusColor;
  final String? tasks;

  factory Standard.fromJson(Map<String, dynamic> json){
    return Standard(
      statusId: json["status_id"],
      statusName: json["status_name"],
      statusReference: json["status_reference"],
      statusColor: json["status_color"],
      tasks: json["tasks"],
    );
  }

}
