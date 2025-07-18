class TaskReportProjectAttachmentResponseModel {
  String? filename;
  String? title;
  Project? project;
  UploadedBy? uploadedBy;
  String? id;
  String? createdAt;
  String? updatedAt;

  TaskReportProjectAttachmentResponseModel(
      {this.filename,
      this.title,
      this.project,
      this.uploadedBy,
      this.id,
      this.createdAt,
      this.updatedAt});

  TaskReportProjectAttachmentResponseModel.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    title = json['title'];
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
    uploadedBy = json['uploaded_by'] != null
        ? UploadedBy.fromJson(json['uploaded_by'])
        : null;
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = filename;
    data['title'] = title;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    if (uploadedBy != null) {
      data['uploaded_by'] = uploadedBy!.toJson();
    }
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Project {
  String? id;
  String? projectName;
  String? billingType;
  String? status;
  int? totalRate;
  int? estimatedHours;
  String? startDate;
  Null deadline;
  String? description;
  String? demoUrl;
  Null finishDate;
  String? liveUrl;
  String? createdAt;
  String? updatedAt;

  Project(
      {this.id,
      this.projectName,
      this.billingType,
      this.status,
      this.totalRate,
      this.estimatedHours,
      this.startDate,
      this.deadline,
      this.description,
      this.demoUrl,
      this.finishDate,
      this.liveUrl,
      this.createdAt,
      this.updatedAt});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
    billingType = json['billing_type'];
    status = json['status'];
    totalRate = json['total_rate'];
    estimatedHours = json['estimated_hours'];
    startDate = json['start_date'];
    deadline = json['deadline'];
    description = json['description'];
    demoUrl = json['demo_url'];
    finishDate = json['finish_date'];
    liveUrl = json['live_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_name'] = projectName;
    data['billing_type'] = billingType;
    data['status'] = status;
    data['total_rate'] = totalRate;
    data['estimated_hours'] = estimatedHours;
    data['start_date'] = startDate;
    data['deadline'] = deadline;
    data['description'] = description;
    data['demo_url'] = demoUrl;
    data['finish_date'] = finishDate;
    data['live_url'] = liveUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UploadedBy {
  String? id;

  UploadedBy({this.id});

  UploadedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
