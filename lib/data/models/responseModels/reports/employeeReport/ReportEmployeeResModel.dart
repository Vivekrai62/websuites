class ReportEmployeeReportResModel {
  final Summary? summary;
  final List<Item>? items;
  final Meta? meta;

  ReportEmployeeReportResModel({
    this.summary,
    this.items,
    this.meta,
  });

  factory ReportEmployeeReportResModel.fromJson(Map<String, dynamic> json) {
    return ReportEmployeeReportResModel(
      summary: json['summary'] != null ? Summary.fromJson(json['summary']) : null,
      items: json['items'] != null
          ? List<Item>.from(json['items'].map((x) => Item.fromJson(x)))
          : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  static List<ReportEmployeeReportResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ReportEmployeeReportResModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      if (summary != null) 'summary': summary!.toJson(),
      if (items != null) 'items': items!.map((x) => x.toJson()).toList(),
      if (meta != null) 'meta': meta!.toJson(),
    };
  }
}


class Summary {
  final Calls? calls;
  final Calls? meetings;
  final int? visitOnly;

  Summary({this.calls, this.meetings, this.visitOnly});

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      calls: json['calls'] != null ? Calls.fromJson(json['calls']) : null,
      meetings: json['meetings'] != null ? Calls.fromJson(json['meetings']) : null,
      visitOnly: json['visitOnly'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (calls != null) 'calls': calls!.toJson(),
      if (meetings != null) 'meetings': meetings!.toJson(),
      'visitOnly': visitOnly,
    };
  }
}

class Calls {
  final int? total;
  final Map<String, int>? callDetails;

  Calls({this.total, this.callDetails});

  factory Calls.fromJson(Map<String, dynamic> json) {
    return Calls(
      total: json['total'],
      callDetails: json['details'] != null
          ? Map<String, int>.from(json['details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      if (callDetails != null) 'details': callDetails,
    };
  }
}


// Remove this class if not used
class CallDetails {
  final int? answered;
  final int? notAnswered;
  final int? wrongNumber;
  final int? busy;
  final int? rejected;
  final int? notReachable;
  final int? switchedOff;

  CallDetails({
    this.answered,
    this.notAnswered,
    this.wrongNumber,
    this.busy,
    this.rejected,
    this.notReachable,
    this.switchedOff,
  });

  factory CallDetails.fromJson(Map<String, dynamic> json) {
    return CallDetails(
      answered: json['Answered'],
      notAnswered: json['Not Answered'],
      wrongNumber: json['Wrong Number'],
      busy: json['Busy'],
      rejected: json['Rejected'],
      notReachable: json['Not Reachable'],
      switchedOff: json['Switched Off'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Answered': answered,
      'Not Answered': notAnswered,
      'Wrong Number': wrongNumber,
      'Busy': busy,
      'Rejected': rejected,
      'Not Reachable': notReachable,
      'Switched Off': switchedOff,
    };
  }
}

class Item {
  // You need to define this based on your API response
  final int? id;

  Item({this.id});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'], // update with actual fields
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // update with actual fields
    };
  }
}

class Meta {
  final int? currentPage;
  final int? itemsPerPage;
  final int? totalPages;
  final int? totalItems;
  final int? itemCount;

  Meta({
    this.currentPage,
    this.itemsPerPage,
    this.totalPages,
    this.totalItems,
    this.itemCount,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['currentPage'],
      itemsPerPage: json['itemsPerPage'],
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
      itemCount: json['itemCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'itemsPerPage': itemsPerPage,
      'totalPages': totalPages,
      'totalItems': totalItems,
      'itemCount': itemCount,
    };
  }
}
