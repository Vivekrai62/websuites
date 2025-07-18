class ColumnUpdateRequestModel {
  String? fieldId;
  List<String>? roleIds;
  List<dynamic>? columnList; // Add this field if you need it

  ColumnUpdateRequestModel({this.fieldId, this.roleIds, this.columnList});

  factory ColumnUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    return ColumnUpdateRequestModel(
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