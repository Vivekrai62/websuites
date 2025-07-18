class DbProjectReminderResModel {
  DbProjectReminderResModel({
    required this.count,
    required this.data,
  });

  final int? count;
  final List<dynamic> data;

  factory DbProjectReminderResModel.fromJson(Map<String, dynamic> json){
    return DbProjectReminderResModel(
      count: json["count"],
      data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    );
  }

}

/*
{
	"count": 0,
	"data": []
}*/