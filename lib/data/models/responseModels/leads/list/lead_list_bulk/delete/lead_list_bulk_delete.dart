class LeadListBulkDeleteResponseModel {
  List<dynamic>? generatedMaps;
  List<dynamic>? raw;
  int? affected;

  LeadListBulkDeleteResponseModel({this.generatedMaps, this.raw, this.affected});

  LeadListBulkDeleteResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['generatedMaps'] != null) {
      generatedMaps = <dynamic>[];
      json['generatedMaps'].forEach((v) {
        generatedMaps!.add(v); // Assuming v is dynamic, so no need to call a specific method.
      });
    }
    if (json['raw'] != null) {
      raw = <dynamic>[];
      json['raw'].forEach((v) {
        raw!.add(v); // Assuming v is dynamic, so no need to call a specific method.
      });
    }
    affected = json['affected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (generatedMaps != null) {
      data['generatedMaps'] = generatedMaps!.map((v) => v).toList();
    }
    if (raw != null) {
      data['raw'] = raw!.map((v) => v).toList();
    }
    data['affected'] = affected;
    return data;
  }
}


