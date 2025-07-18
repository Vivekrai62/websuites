class ProjectReminderSetting {
  List<Dates>? dates;
  String? project;
  List<String>? users;

  ProjectReminderSetting({this.dates, this.project, this.users});

  ProjectReminderSetting.fromJson(Map<String, dynamic> json) {
    if (json['dates'] != null) {
      dates = <Dates>[];
      json['dates'].forEach((v) {
        dates!.add(Dates.fromJson(v));
      });
    }
    project = json['project'];
    users = json['users'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dates != null) {
      data['dates'] = dates!.map((v) => v.toJson()).toList();
    }
    data['project'] = project;
    data['users'] = users;
    return data;
  }
}

class Dates {
  String? day;
  String? month;

  Dates({this.day, this.month});

  Dates.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['month'] = month;
    return data;
  }
}
