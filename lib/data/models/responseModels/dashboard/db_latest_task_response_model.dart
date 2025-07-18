class DbLatestTaskResponseModel {
  List<Items>? items;
  Meta? meta;
  Null user_key;
  Null members;

  DbLatestTaskResponseModel({
    this.items,
    this.meta,
    this.user_key,
    this.members,
});

  DbLatestTaskResponseModel.fromJson(Map<String, dynamic> json) {
    if(json['items'] != null) {
      items = <Items> [];
      json['items'].forEach((v){
        items!.add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null? Meta.fromJson(json['meta']) : null;
    user_key = json['user_key'];
    members = json['members'];
  }

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic> {};
    if(items != null) {
      data['items'] = items !. map((v) => v.toJson()).toList();
    }
    if(meta != null) {
      data['meta'] = meta !.toJson();
    }
    data['user_key'] = user_key;
    data['members'] = members;
    return data;
  }
}

class Items {
  String? id;
  String? subject;
  String? description;
  String? start_date;
  String? deadline;
  String? priority;
  String? status_date_time;
  int? estimated_minutes;
  int? time_taken;
  String? created_at;
  String? updated_at;
  bool? is_sequential_task;
  int? order;
  List<Attachments>? attachments;
  CreatedBy? created_by;
  List<Assigned>? assigned;
  TaskType? task_type;
  List<Histories>? histories;
  Status? status;

  Items({
    this.id,
    this.subject,
    this.description,
    this.start_date,
    this.deadline,
    this.priority,
    this.status_date_time,
    this.estimated_minutes,
    this.time_taken,
    this.created_at,
    this.updated_at,
    this.is_sequential_task,
    this.order,
    this.attachments,
    this.created_by,
    this.assigned,
    this.task_type,
    this.histories,
    this.status
});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    description = json['description'];
    start_date = json['start_date'];
    deadline = json['deadline'];
    priority = json['priority'];
    status_date_time = json['status_date_time'];
    estimated_minutes = json['estimated_minutes'];
    time_taken = json['time_taken'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    is_sequential_task = json['is_sequential_task'];
    order = json['order'];
    if(json['attachments'] != null) {
      attachments = <Attachments> [];
      json['attachments'].forEach((v){
        attachments!.add(Attachments.fromJson(v));
      });
    }
    created_by = json['created_by'] != null ? CreatedBy.fromJson(json['created_by']) : null;
    if(json['assigned'] != null) {
      assigned = <Assigned> [];
      json['assigned'].forEach((v){
        assigned!.add(Assigned.fromJson(v));
      });
    }
    task_type = json['task_type'] != null? TaskType.fromJson(json['task_type']): null;
    if(json['histories'] != null) {
      histories = <Histories> [];
      json['histories'].forEach((v){
        histories!. add(Histories.fromJson(v));
      });
    }

    status = json['status'] != null ? Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['subject'] = subject;
    data['description'] = description;
    data['start_date'] = start_date;
    data['deadline'] = deadline;
    data['priority'] = priority;
    data['status_date_time'] = status_date_time;
    data['estimated_minutes'] = estimated_minutes;
    data['time_taken'] = time_taken;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['is_sequential_task'] = is_sequential_task;
    data['order'] = order;
    if(attachments != null) {
      data['attachments'] = attachments !.map((v) => toJson()).toList();
    }
    if(created_by != null) {
      data['created_by'] = created_by !. toJson();
    }
    if(assigned != null) {
      data['assigned'] = assigned !. map((v) => v.toJson()).toList();
    }
    if(task_type != null) {
      data['task_type'] = task_type !.toJson();
    }
    if(histories != null) {
      data['histories'] = histories !.map((v) => v.toJson()).toList();
    }
    if(status != null) {
      data['status'] = status !. toJson();
    }
    return data;
  }
}

class Attachments {
  String? email;

  Attachments ({this.email});

  Attachments.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic> {};
    data['email'] = email;
    return data;
  }
}

class Histories {
  String? id;
  String? remark;
  String? notify;
  String? created_at;
  String? updated_at;

  Histories ({
    this.id,
    this.remark,
    this.notify,
    this.created_at,
    this.updated_at
});

  Histories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remark = json['remark'];
    notify = json['notify'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['remark'] = remark;
    data['notify'] = notify;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    return data;
  }
}

class TaskType {
  String? id;
  String? name;
  String? created_at;
  bool? status;
  String? updated_at;

  TaskType ({
    this.id,
    this.name,
    this.created_at,
    this.status,
    this.updated_at
});

  TaskType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    created_at = json['created_at'];
    status = json['status'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = created_at;
    data['status'] = status;
    data['updated_at'] = updated_at;
    return data;
  }
}

class Assigned {
  String? id;
  int? status;
  String? created_at;
  String? updated_at;
  AssignedTo? assigned_to;

  Assigned({
    this.id,
    this.status,
    this.created_at,
    this.updated_at,
    this.assigned_to
});

  Assigned.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    assigned_to = json['assigned_to'] != null ? AssignedTo.fromJson(json['assigned_to']) : null;
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['status'] = status;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    if(assigned_to != null) {
      data['assigned_to'] = assigned_to!. toJson();
    }
    return data;
  }
}

class AssignedTo {
  String? id;
  String? first_name;
  String? last_name;

  AssignedTo ({
    this.id,
    this.first_name,
    this.last_name
});

  AssignedTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    return data;
  }
}

class CreatedBy {
  String? id;
  String? first_name;
  String? last_name;

  CreatedBy ({
    this.id,
    this.last_name,
    this.first_name
});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    last_name = json['last_name'];
    first_name = json['first_name'];
  }

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['last_name'] = last_name;
    data['first_name'] = first_name;
    return data;
  }
}

class Status {
  String? id;
  String? name;
  String? reference;
  bool? isdefault;
  String? color;
  bool? status;
  int? order;
  String? description;
  String? created_at;
  String? updated_at;


  Status ({
    this.id,
    this.name,
    this.reference,
    this.isdefault,
    this.color,
    this.status,
    this.order,
    this.description,
    this.updated_at,
    this.created_at
});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    reference = json['reference'];
    isdefault = json['isdefault'];
    color = json['color'];
    status = json['status'];
    order = json['order'];
    description = json['description'];
    updated_at = json['updated_at'];
    created_at = json['created_at'];
  }
  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['name'] = name;
    data['reference'] = reference;
    data['isdefault'] = isdefault;
    data['color'] = color;
    data['status'] = status;
    data['order'] = order;
    data['description'] = description;
    data['updated_at'] = updated_at;
    data['created_at'] = created_at;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? itemsPerPage;
  int? totalPages;
  int? totalItems;
  int? itemCount;

  Meta ({
    this.currentPage,
    this.itemsPerPage,
    this.totalItems,
    this.totalPages,
    this.itemCount
});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPages'];
    itemsPerPage = json['itemsPerPage'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    itemCount = json['itemsCount'];
  }

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic> {};
    data['currentPage'] = currentPage;
    data['itemsPerPage'] = itemsPerPage;
    data['totalItems'] = totalItems;
    data['totalPages'] = totalPages;
    data['itemCount'] = itemCount;
    return data;
  }
}




