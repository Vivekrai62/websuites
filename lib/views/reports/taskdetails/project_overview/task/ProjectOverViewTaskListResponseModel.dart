class ProjectOverViewTaskListResponseModel {
  ProjectOverViewTaskListResponseModel({
    required this.items,
    required this.meta,
    required this.userKey,
    required this.members,
  });

  final List<Item> items;
  final Meta? meta;
  final String? userKey;
  final List<Member> members;

  factory ProjectOverViewTaskListResponseModel.fromJson(Map<String, dynamic> json){
    return ProjectOverViewTaskListResponseModel(
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      userKey: json["user_key"],
      members: json["members"] == null ? [] : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
    );
  }

}

class Item {
  Item({
    required this.id,
    required this.subject,
    required this.description,
    required this.startDate,
    required this.deadline,
    required this.priority,
    required this.estimatedMinutes,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.assigned,
    required this.taskType,
    required this.status,
    required this.project,
  });

  final String? id;
  final String? subject;
  final String? description;
  final DateTime? startDate;
  final dynamic deadline;
  final String? priority;
  final int? estimatedMinutes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final CreatedBy? createdBy;
  final List<Assigned> assigned;
  final TaskType? taskType;
  final Status? status;
  final Project? project;

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      id: json["id"],
      subject: json["subject"],
      description: json["description"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      deadline: json["deadline"],
      priority: json["priority"],
      estimatedMinutes: json["estimated_minutes"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
      assigned: json["assigned"] == null ? [] : List<Assigned>.from(json["assigned"]!.map((x) => Assigned.fromJson(x))),
      taskType: json["task_type"] == null ? null : TaskType.fromJson(json["task_type"]),
      status: json["status"] == null ? null : Status.fromJson(json["status"]),
      project: json["project"] == null ? null : Project.fromJson(json["project"]),
    );
  }

}

class Assigned {
  Assigned({
    required this.id,
    required this.status,
    required this.assignedTo,
  });

  final String? id;
  final int? status;
  final CreatedBy? assignedTo;

  factory Assigned.fromJson(Map<String, dynamic> json){
    return Assigned(
      id: json["id"],
      status: json["status"],
      assignedTo: json["assigned_to"] == null ? null : CreatedBy.fromJson(json["assigned_to"]),
    );
  }

}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.status,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final bool? status;

  factory CreatedBy.fromJson(Map<String, dynamic> json){
    return CreatedBy(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      status: json["status"],
    );
  }

}

class Project {
  Project({
    required this.id,
    required this.projectName,
  });

  final String? id;
  final String? projectName;

  factory Project.fromJson(Map<String, dynamic> json){
    return Project(
      id: json["id"],
      projectName: json["project_name"],
    );
  }

}

class Status {
  Status({
    required this.id,
    required this.name,
    required this.color,
  });

  final String? id;
  final String? name;
  final String? color;

  factory Status.fromJson(Map<String, dynamic> json){
    return Status(
      id: json["id"],
      name: json["name"],
      color: json["color"],
    );
  }

}

class TaskType {
  TaskType({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory TaskType.fromJson(Map<String, dynamic> json){
    return TaskType(
      id: json["id"],
      name: json["name"],
    );
  }

}

class Member {
  Member({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.address,
    required this.bio,
    required this.profilePic,
    required this.password,
    required this.status,
    required this.rememberToken,
    required this.rememberTokenTime,
    required this.memberDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceId,
    required this.tracking,
    required this.crmCategory,
    required this.mobileApp,
    required this.superSettings,
    required this.roleList,
    required this.mailjetSender,
    required this.smtpSender,
    required this.smsSender,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;
  final String? address;
  final String? bio;
  final String? profilePic;
  final String? password;
  final bool? status;
  final String? rememberToken;
  final dynamic rememberTokenTime;
  final bool? memberDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deviceId;
  final bool? tracking;
  final String? crmCategory;
  final bool? mobileApp;
  final bool? superSettings;
  final List<RoleList> roleList;
  final Sender? mailjetSender;
  final Sender? smtpSender;
  final dynamic smsSender;

  factory Member.fromJson(Map<String, dynamic> json){
    return Member(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      mobile: json["mobile"],
      address: json["address"],
      bio: json["bio"],
      profilePic: json["profile_pic"],
      password: json["password"],
      status: json["status"],
      rememberToken: json["remember_token"],
      rememberTokenTime: json["remember_token_time"],
      memberDefault: json["default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deviceId: json["device_id"],
      tracking: json["tracking"],
      crmCategory: json["crm_category"],
      mobileApp: json["mobile_app"],
      superSettings: json["superSettings"],
      roleList: json["role_list"] == null ? [] : List<RoleList>.from(json["role_list"]!.map((x) => RoleList.fromJson(x))),
      mailjetSender: json["mailjetSender"] == null ? null : Sender.fromJson(json["mailjetSender"]),
      smtpSender: json["smtpSender"] == null ? null : Sender.fromJson(json["smtpSender"]),
      smsSender: json["smsSender"],
    );
  }

}

class Sender {
  Sender({
    required this.id,
    required this.provider,
    required this.name,
    required this.email,
    required this.status,
    required this.mailjetSenderId,
    required this.smtpHost,
    required this.smtpPassword,
    required this.smtpPort,
    required this.smtpAuthentication,
    required this.isDefaultSender,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? provider;
  final String? name;
  final String? email;
  final bool? status;
  final String? mailjetSenderId;
  final String? smtpHost;
  final String? smtpPassword;
  final int? smtpPort;
  final dynamic smtpAuthentication;
  final bool? isDefaultSender;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Sender.fromJson(Map<String, dynamic> json){
    return Sender(
      id: json["id"],
      provider: json["provider"],
      name: json["name"],
      email: json["email"],
      status: json["status"],
      mailjetSenderId: json["mailjet_sender_id"],
      smtpHost: json["smtp_host"],
      smtpPassword: json["smtp_password"],
      smtpPort: json["smtp_port"],
      smtpAuthentication: json["smtp_authentication"],
      isDefaultSender: json["is_default_sender"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class RoleList {
  RoleList({
    required this.id,
    required this.name,
    required this.description,
    required this.roleListDefault,
  });

  final String? id;
  final String? name;
  final String? description;
  final bool? roleListDefault;

  factory RoleList.fromJson(Map<String, dynamic> json){
    return RoleList(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      roleListDefault: json["default"],
    );
  }

}

class Meta {
  Meta({
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemCount,
  });

  final int? currentPage;
  final int? itemsPerPage;
  final int? totalPages;
  final int? totalItems;
  final int? itemCount;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      currentPage: json["currentPage"],
      itemsPerPage: json["itemsPerPage"],
      totalPages: json["totalPages"],
      totalItems: json["totalItems"],
      itemCount: json["itemCount"],
    );
  }

}
