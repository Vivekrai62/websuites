class LeadDetailsNoteCreateResMode {
  String? message;

  LeadDetailsNoteCreateResMode({this.message});

  LeadDetailsNoteCreateResMode.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    return data;
  }

  // ✅ Add this static method to handle list deserialization
  static List<LeadDetailsNoteCreateResMode> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadDetailsNoteCreateResMode.fromJson(json))
        .toList();
  }
}
