class HrmAttendanceResponseModel {
  String? id;
  String? date;
  String? name;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;


  HrmAttendanceResponseModel({
    this.id,
    this.date,
    this.name,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });


  HrmAttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    name = json['name'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  // Method to convert the instance back to a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['name'] = name;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
