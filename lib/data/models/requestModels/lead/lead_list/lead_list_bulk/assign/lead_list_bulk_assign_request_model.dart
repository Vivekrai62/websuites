class LeadListBulkAssignRequestModel {
  List<String>? lead;

  LeadListBulkAssignRequestModel({this.lead});

  LeadListBulkAssignRequestModel.fromJson(Map<String, dynamic> json) {
    lead = json['lead'] != null ? List<String>.from(json['lead']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'lead': lead,
    };
  }
}
