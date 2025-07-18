class CustomerActivityReportResponseModel {
  List<Items>? items;
  Meta? meta;

  CustomerActivityReportResponseModel({this.items, this.meta});

  CustomerActivityReportResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? email;
  String? mobile;
  int? orders;
  int? revenue;
  int? ordersAmount;
  int? revenuePending;
  int? revenueApproved;
  Activities? activities;

  Items(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.orders,
      this.revenue,
      this.ordersAmount,
      this.revenuePending,
      this.revenueApproved,
      this.activities});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    orders = json['orders'];
    revenue = json['revenue'];
    ordersAmount = json['ordersAmount'];
    revenuePending = json['revenuePending'];
    revenueApproved = json['revenueApproved'];
    activities = json['activities'] != null
        ? Activities.fromJson(json['activities'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['orders'] = orders;
    data['revenue'] = revenue;
    data['ordersAmount'] = ordersAmount;
    data['revenuePending'] = revenuePending;
    data['revenueApproved'] = revenueApproved;
    if (activities != null) {
      data['activities'] = activities!.toJson();
    }
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
  FeedbackCallAnswered? feedbackCallAnswered;
  FeedbackCallAnswered? answered;
  FeedbackCallAnswered? notAnswered;

  Details({this.feedbackCallAnswered, this.answered, this.notAnswered});

  Details.fromJson(Map<String, dynamic> json) {
    feedbackCallAnswered = json['Feedback Call - Answered'] != null
        ? FeedbackCallAnswered.fromJson(json['Feedback Call - Answered'])
        : null;
    answered = json['Answered'] != null
        ? FeedbackCallAnswered.fromJson(json['Answered'])
        : null;
    notAnswered = json['Not Answered'] != null
        ? FeedbackCallAnswered.fromJson(json['Not Answered'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feedbackCallAnswered != null) {
      data['Feedback Call - Answered'] = feedbackCallAnswered!.toJson();
    }
    if (answered != null) {
      data['Answered'] = answered!.toJson();
    }
    if (notAnswered != null) {
      data['Not Answered'] = notAnswered!.toJson();
    }
    return data;
  }
}

class FeedbackCallAnswered {
  String? id;
  int? count;

  FeedbackCallAnswered({this.id, this.count});

  FeedbackCallAnswered.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['count'] = count;
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
