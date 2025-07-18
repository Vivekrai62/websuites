class UpdateDivisionResponseModels {
  String? message;
  int? code;

  UpdateDivisionResponseModels({this.message, this.code});

  UpdateDivisionResponseModels.fromJson(Map<String, dynamic> json) {
    message = json['message'] as String?;
    code = json['code'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}