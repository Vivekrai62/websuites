class LeadListRequestModel {
  LeadListRequestModel({
    required this.paginationType,
    required this.page,
    required this.search,
    required this.notificationId,
    required this.reminderRange,
    required this.assignedType,
    required this.assignedRange,
    required this.city,
    required this.country,
    required this.customFields,
    required this.division,
    required this.isOpen,
    required this.isForeignLead,
    required this.lastActivityRange,
    required this.leadAssigned,
    required this.leadAssignedToTeam,
    required this.leadDeadReason,
    required this.limit,
    required this.noCampaign,
    required this.productCategory,
    required this.queryType,
    required this.range,
    required this.reminderType,
    required this.repeatType,
    required this.serviceType,
    required this.sortBy,
    required this.sortDir,
    required this.source,
    required this.state,
    required this.status,
    required this.subTypes,
    required this.toDoList,
    required this.todoLeads,
    required this.type,
    required this.unhandle,
  });

  final String? paginationType;
  final int? page;
  final String? search;
  final String? notificationId;
  final dynamic reminderRange;
  final dynamic assignedType;
  final dynamic assignedRange;
  final String? city;
  final dynamic country;
  final CustomFields? customFields;
  final String? division;
  final bool? isOpen;
  final bool? isForeignLead;
  final dynamic lastActivityRange;
  final String? leadAssigned;
  final bool? leadAssignedToTeam;
  final String? leadDeadReason;
  final int? limit;
  final bool? noCampaign;
  final String? productCategory;
  final String? queryType;
  final dynamic range;
  final dynamic reminderType;
  final dynamic repeatType;
  final List<dynamic> serviceType;
  final String? sortBy;
  final String? sortDir;
  final String? source;
  final dynamic state;
  final dynamic status;
  final List<dynamic> subTypes;
  final dynamic toDoList;
  final dynamic todoLeads;
  final String? type;
  final String? unhandle;

  factory LeadListRequestModel.fromJson(Map<String, dynamic> json) {
    return LeadListRequestModel(
      paginationType: json["pagination_type"],
      page: json["page"],
      search: json["search"],
      notificationId: json["notification_id"],
      reminderRange: json["reminder_range"],
      assignedType: json["assignedType"],
      assignedRange: json["assigned_range"],
      city: json["city"],
      country: json["country"],
      customFields: json["custom_fields"] == null ? null : CustomFields.fromJson(json["custom_fields"]),
      division: json["division"],
      isOpen: json["isOpen"],
      isForeignLead: json["is_foreign_lead"],
      lastActivityRange: json["lastActivityRange"],
      leadAssigned: json["lead_assigned"],
      leadAssignedToTeam: json["lead_assigned_to_team"],
      leadDeadReason: json["lead_dead_reason"],
      limit: json["limit"],
      noCampaign: json["no_campaign"],
      productCategory: json["productCategory"],
      queryType: json["query_type"],
      range: json["range"],
      reminderType: json["reminderType"],
      repeatType: json["repeatType"],
      serviceType: json["service_type"] == null ? [] : List<dynamic>.from(json["service_type"]!.map((x) => x)),
      sortBy: json["sort_by"],
      sortDir: json["sort_dir"],
      source: json["source"],
      state: json["state"],
      status: json["status"],
      subTypes: json["sub_types"] == null ? [] : List<dynamic>.from(json["sub_types"]!.map((x) => x)),
      toDoList: json["toDoList"],
      todoLeads: json["todoLeads"],
      type: json["type"],
      unhandle: json["unhandle"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pagination_type": paginationType,
      "page": page,
      "search": search,
      "notification_id": notificationId,
      "reminder_range": reminderRange,
      "assignedType": assignedType,
      "assigned_range": assignedRange,
      "city": city,
      "country": country,
      "custom_fields": customFields?.json,
      "division": division,
      "isOpen": isOpen,
      "is_foreign_lead": isForeignLead,
      "lastActivityRange": lastActivityRange,
      "lead_assigned": leadAssigned,
      "lead_assigned_to_team": leadAssignedToTeam,
      "lead_dead_reason": leadDeadReason,
      "limit": limit,
      "no_campaign": noCampaign,
      "productCategory": productCategory,
      "query_type": queryType,
      "range": range,
      "reminderType": reminderType,
      "repeatType": repeatType,
      "service_type": serviceType,
      "sort_by": sortBy,
      "sort_dir": sortDir,
      "source": source,
      "state": state,
      "status": status,
      "sub_types": subTypes,
      "toDoList": toDoList,
      "todoLeads": todoLeads,
      "type": type,
      "unhandle": unhandle,
    };
  }
}

class CustomFields {
  CustomFields({required this.json});
  final Map<String, dynamic> json;

  factory CustomFields.fromJson(Map<String, dynamic> json) {
    return CustomFields(json: json);
  }

  Map<String, dynamic> toJson() {
    return json;
  }
}