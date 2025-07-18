class CallCreateRequest {
  final String activity;
  final String subActivity;
  final String remark;
  final double lat;
  final double lng;
  final DateTime reminder;
  final String reminderTo;
  final bool informedToCustomer;
  final List<String> ccTo;

  CallCreateRequest({
    required this.activity,
    required this.subActivity,
    required this.remark,
    required this.lat,
    required this.lng,
    required this.reminder,
    required this.reminderTo,
    required this.informedToCustomer,
    required this.ccTo,
  });

  // Convert a JSON map to a CallRequest instance
  factory CallCreateRequest.fromJson(Map<String, dynamic> json) {
    return CallCreateRequest(
      activity: json['activity'],
      subActivity: json['sub_activity'],
      remark: json['remark'],
      lat: json['lat'],
      lng: json['lng'],
      reminder: DateTime.parse(json['reminder']),
      reminderTo: json['reminder_to'],
      informedToCustomer: json['informed_to_customer'],
      ccTo: List<String>.from(json['cc_to']),
    );
  }

  // Convert a CallRequest instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'sub_activity': subActivity,
      'remark': remark,
      'lat': lat,
      'lng': lng,
      'reminder': reminder.toIso8601String(),
      'reminder_to': reminderTo,
      'informed_to_customer': informedToCustomer,
      'cc_to': ccTo,
    };
  }
}