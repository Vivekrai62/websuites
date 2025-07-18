class DbPaymentReminderResModel {
  DbPaymentReminderResModel({
    required this.missing,
    required this.today,
    required this.upcoming,
    required this.data,
  });

  final int? missing;
  final int? today;
  final int? upcoming;
  final List<dynamic> data;

  factory DbPaymentReminderResModel.fromJson(Map<String, dynamic> json){
    return DbPaymentReminderResModel(
      missing: json["missing"],
      today: json["today"],
      upcoming: json["upcoming"],
      data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    );
  }

}

/*
{
	"missing": 0,
	"today": 0,
	"upcoming": 0,
	"data": []
}*/