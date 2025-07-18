class MainDashLeadCardListRespoModel {
  MainDashLeadCardListRespoModel({
    required this.mainDashLeadCardListRespoModelNew,
    required this.inProgress,
    required this.repeat,
    required this.unhandled,
    required this.unassigned,
    required this.toDoLead,
    required this.deadLead,
  });

  final int? mainDashLeadCardListRespoModelNew;
  final int? inProgress;
  final int? repeat;
  final int? unhandled;
  final int? unassigned;
  final int? toDoLead;
  final int? deadLead;

  factory MainDashLeadCardListRespoModel.fromJson(Map<String, dynamic> json){
    return MainDashLeadCardListRespoModel(
      mainDashLeadCardListRespoModelNew: json["new"],
      inProgress: json["inProgress"],
      repeat: json["repeat"],
      unhandled: json["unhandled"],
      unassigned: json["unassigned"],
      toDoLead: json["toDoLead"],
      deadLead: json["deadLead"],
    );
  }

}
