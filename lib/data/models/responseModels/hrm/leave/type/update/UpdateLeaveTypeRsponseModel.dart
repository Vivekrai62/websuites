class UpdateLeaveTypeResponseModel {
  List<dynamic>? generatedMaps;
  List<dynamic>? raw;
  int? affected;

  UpdateLeaveTypeResponseModel({this.generatedMaps, this.raw, this.affected});

  UpdateLeaveTypeResponseModel.fromJson(Map<String, dynamic> json) {

    if (json['generatedMaps'] != null) {
      generatedMaps = List<dynamic>.from(json['generatedMaps']);
    }


    if (json['raw'] != null) {
      raw = List<dynamic>.from(json['raw']);
    }

    // Safely assign the 'affected' value
    affected = json['affected'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    // Only add the customer_list if it's not null
    if (generatedMaps != null) {
      data['generatedMaps'] = generatedMaps!;
    }

    if (raw != null) {
      data['raw'] = raw!;
    }


    if (affected != null) {
      data['affected'] = affected;
    }

    return data;
  }
}


class LeaveModel {
  String? type;
  String? name;
  String? shortCode;
  String? description;
  String? paidOption;

  LeaveModel({
    this.type,
    this.name,
    this.shortCode,
    this.description,
    this.paidOption,
  });
}