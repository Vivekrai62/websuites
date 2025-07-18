class FieldUpdateRequestModel {
  String? fieldId;
  List<String>? roleIds;
  List<dynamic>? columnList; // Add this field if you need it

  FieldUpdateRequestModel({this.fieldId, this.roleIds, this.columnList});

  factory FieldUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    return FieldUpdateRequestModel(
      fieldId: json['fieldId'] as String?,
      roleIds: json['roleIds'] != null ? List<String>.from(json['roleIds']) : null,
      columnList: json['columnList'] != null ? List<dynamic>.from(json['columnList']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fieldId': fieldId,
      'roleIds': roleIds,
      'columnList': columnList,
    };
  }
}