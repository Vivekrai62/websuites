// Add this class to your models or update your existing model
class GlobalSettingResModel {
  final bool smsEnabled;
  final bool whatsappEnabled;
  final bool mailEnabled;
  final bool otpRequiredForMeetings;
  final bool disableCustomerCompanies;
  final bool countryCode;
  final bool locationRequiredOnLeadActivity;
  final bool locationRequiredOnCustomerActivity;
  final bool disableAutoAssignRepeatedLeads;
  final bool invetory;

  GlobalSettingResModel({
    this.smsEnabled = false,
    this.whatsappEnabled = false,
    this.mailEnabled = false,
    this.otpRequiredForMeetings = false,
    this.disableCustomerCompanies = false,
    this.countryCode = false,
    this.locationRequiredOnLeadActivity = false,
    this.locationRequiredOnCustomerActivity = false,
    this.disableAutoAssignRepeatedLeads = false,
    this.invetory = false,
  });

  factory GlobalSettingResModel.fromJson(Map<String, dynamic> json) {
    return GlobalSettingResModel (
      smsEnabled: json['sms_enabled'] ?? false,
      whatsappEnabled: json['whatsapp_enabled'] ?? false,
      mailEnabled: json['mail_enabled'] ?? false,
      otpRequiredForMeetings: json['otp_required_for_meetings'] ?? false,
      disableCustomerCompanies: json['disable_customer_companies'] ?? false,
      countryCode: json['country_code'] ?? false,
      locationRequiredOnLeadActivity: json['location_required_on_lead_activity'] ?? false,
      locationRequiredOnCustomerActivity: json['location_required_on_customer_activity'] ?? false,
      disableAutoAssignRepeatedLeads: json['disable_auto_assign_repeated_leads'] ?? false,
      invetory: json['invetory'] ?? false,
    );
  }
}