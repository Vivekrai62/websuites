// class StaticValueModel {
//   final List<Map<String, dynamic>> constantType;
//
//   StaticValueModel({required this.constantType});
//
//   // Factory constructor to update an instance from JSON
//   factory StaticValueModel.fromJson(Map<String, dynamic> json) {
//     return StaticValueModel(
//       constantType: List<Map<String, dynamic>>.from(json['nestType']),
//     );
//   }
//
//   // Method to convert the model to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'nestType': constantType,
//     };
//   }
// }


class StaticValueModel {
  final LeadList leadList;
  final LeadActivity leadActivity;

  StaticValueModel({required this.leadList, required this.leadActivity});

  // Factory constructor to update an instance from JSON
  factory StaticValueModel.fromJson(Map<String, dynamic> json) {
    return StaticValueModel(
      leadList: LeadList.fromJson(json['leadlist']),
      leadActivity: LeadActivity.fromJson(json['lead_activity']),
    );
  }

  // Method to convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'leadlist': leadList.toJson(),
      'lead_activity': leadActivity.toJson(),
    };
  }
}

class LeadList {
  final List<String> todo;
  final List<String> queryType;


  LeadList({required this.todo, required this.queryType});

  factory LeadList.fromJson(Map<String, dynamic> json) {
    return LeadList(
      todo: List<String>.from(json['todo']),
      queryType: List<String>.from(json['query_type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todo': todo,
      'query_type': queryType,
    };
  }
}

class LeadActivity {
  final Daily daily;

  LeadActivity({required this.daily});

  factory LeadActivity.fromJson(Map<String, dynamic> json) {
    return LeadActivity(
      daily: Daily.fromJson(json['daily']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'daily': daily.toJson(),
    };
  }
}

class Daily {
  final List<String> byActivity;
  final NoActivities noActivities;

  Daily({required this.byActivity, required this.noActivities});

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      byActivity: List<String>.from(json['by_activity']),
      noActivities: NoActivities.fromJson(json['noactivities']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'by_activity': byActivity,
      'noactivities': noActivities.toJson(),
    };
  }
}

class NoActivities {
  final List<String> forActivities;
  final List<String> activitySince;

  NoActivities({required this.forActivities, required this.activitySince});

  factory NoActivities.fromJson(Map<String, dynamic> json) {
    return NoActivities(
      forActivities: List<String>.from(json['for']),
      activitySince: List<String>.from(json['activity_since']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'for': forActivities,
      'activity_since': activitySince,
    };
  }
}
