class ActivityCustomerReportResponseModel {
  List<Items>? items;
  Meta? meta;

  ActivityCustomerReportResponseModel({this.items, this.meta});

  ActivityCustomerReportResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Items {
  String? id;
  String? name;
  String? primaryEmail;
  String? primaryContact;
  Company? company;
  int? orders;
  int? revenue;
  Activities? activities;

  Items(
      {this.id,
      this.name,
      this.primaryEmail,
      this.primaryContact,
      this.company,
      this.orders,
      this.revenue,
      this.activities});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    primaryEmail = json['primary_email'];
    primaryContact = json['primary_contact'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    orders = json['orders'];
    revenue = json['revenue'];
    activities = json['activities'] != null
        ? Activities.fromJson(json['activities'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['primary_email'] = primaryEmail;
    data['primary_contact'] = primaryContact;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['orders'] = orders;
    data['revenue'] = revenue;
    if (activities != null) {
      data['activities'] = activities!.toJson();
    }
    return data;
  }
}

class Company {
  String? id;
  String? companyName;

  Company({this.id, this.companyName});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    return data;
  }
}

class Activities {
  Calls? calls;
  Calls? meetings;

  Activities({this.calls, this.meetings});

  Activities.fromJson(Map<String, dynamic> json) {
    calls = json['calls'] != null ? Calls.fromJson(json['calls']) : null;
    meetings =
        json['meetings'] != null ? Calls.fromJson(json['meetings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (calls != null) {
      data['calls'] = calls!.toJson();
    }
    if (meetings != null) {
      data['meetings'] = meetings!.toJson();
    }
    return data;
  }
}

class Calls {
  int? count;
  Details? details;

  Calls({this.count, this.details});

  Calls.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class Details {
  int? feedbackCallAnswered;

  Details({this.feedbackCallAnswered});

  Details.fromJson(Map<String, dynamic> json) {
    feedbackCallAnswered = json['Feedback Call - Answered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Feedback Call - Answered'] = feedbackCallAnswered;
    return data;
  }
}

class Detail {
  Detail();

  Detail.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

class Meta {
  int? currentPage;
  int? itemsPerPage;
  int? totalPages;
  int? totalItems;
  int? itemCount;

  Meta(
      {this.currentPage,
      this.itemsPerPage,
      this.totalPages,
      this.totalItems,
      this.itemCount});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    itemsPerPage = json['itemsPerPage'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['itemsPerPage'] = itemsPerPage;
    data['totalPages'] = totalPages;
    data['totalItems'] = totalItems;
    data['itemCount'] = itemCount;
    return data;
  }
}

class Activity {
  Calls? calls;
  Calls? meetings;

  Activity({this.calls, this.meetings});

  Activity.fromJson(Map<String, dynamic> json) {
    calls = json['calls'] != null ? Calls.fromJson(json['calls']) : null;
    meetings =
        json['meetings'] != null ? Calls.fromJson(json['meetings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (calls != null) {
      data['calls'] = calls!.toJson();
    }
    if (meetings != null) {
      data['meetings'] = meetings!.toJson();
    }
    return data;
  }
}
