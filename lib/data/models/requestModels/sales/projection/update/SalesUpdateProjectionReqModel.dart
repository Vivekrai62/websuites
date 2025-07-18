class SalesUpdateProjectionReqModel {
  String? projectionDate;
  int? amount; // Ensure this is an int

  SalesUpdateProjectionReqModel({this.projectionDate, this.amount});

  SalesUpdateProjectionReqModel.fromJson(Map<String, dynamic> json) {
    projectionDate = json['projection_date']?.toString();
    amount = json['amount'] != null
        ? int.tryParse(json['amount'].toString())
        : null; // Parse as int
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['projection_date'] = projectionDate;
    data['amount'] = amount; // Keep as int
    return data;
  }
}
