class DailySalesReportsResponseModel {
  List<Items>? items;
  Meta? meta;

  DailySalesReportsResponseModel({this.items, this.meta});

  DailySalesReportsResponseModel.fromJson(Map<String, dynamic> json) {
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
  Activities? activities;

  Items({this.id, this.name, this.email, this.mobile, this.activities});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  Answered? answered;
  Answered? notAnswered;
  Answered? wrongNumber;
  Answered? numberBusy;
  Answered? meetingFixed;
  Answered? lookingForJob;

  Details(
      {this.answered,
      this.notAnswered,
      this.wrongNumber,
      this.numberBusy,
      this.meetingFixed,
      this.lookingForJob});

  Details.fromJson(Map<String, dynamic> json) {
    answered =
        json['Answered'] != null ? Answered.fromJson(json['Answered']) : null;
    notAnswered = json['Not Answered'] != null
        ? Answered.fromJson(json['Not Answered'])
        : null;
    wrongNumber = json['Wrong Number'] != null
        ? Answered.fromJson(json['Wrong Number'])
        : null;
    numberBusy = json['Number Busy'] != null
        ? Answered.fromJson(json['Number Busy'])
        : null;
    meetingFixed = json['Meeting Fixed'] != null
        ? Answered.fromJson(json['Meeting Fixed'])
        : null;
    lookingForJob = json['Looking For Job'] != null
        ? Answered.fromJson(json['Looking For Job'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (answered != null) {
      data['Answered'] = answered!.toJson();
    }
    if (notAnswered != null) {
      data['Not Answered'] = notAnswered!.toJson();
    }
    if (wrongNumber != null) {
      data['Wrong Number'] = wrongNumber!.toJson();
    }
    if (numberBusy != null) {
      data['Number Busy'] = numberBusy!.toJson();
    }
    if (meetingFixed != null) {
      data['Meeting Fixed'] = meetingFixed!.toJson();
    }
    if (lookingForJob != null) {
      data['Looking For Job'] = lookingForJob!.toJson();
    }
    return data;
  }
}

class Answered {
  String? id;
  int? count;

  Answered({this.id, this.count});

  Answered.fromJson(Map<String, dynamic> json) {
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

// class Details {
//   Answered? virtual;
//   Answered? physical;
//
//   Details({this.virtual, this.physical});
//
//   Details.fromJson(Map<String, dynamic> json) {
//     virtual =
//     json['Virtual'] != null ? new Answered.fromJson(json['Virtual']) : null;
//     physical = json['Physical'] != null
//         ? new Answered.fromJson(json['Physical'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.virtual != null) {
//       data['Virtual'] = this.virtual!.toJson();
//     }
//     if (this.physical != null) {
//       data['Physical'] = this.physical!.toJson();
//     }
//     return data;
//   }
// }

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
