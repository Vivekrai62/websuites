// File: lib/data/models/requestModels/globalSetting/update/GlobalSettingCheckReqModel.dart

class GlobalSettingCheckReqModel {
  final String activity;
  final String callStatus;
  final String remark;
  final double lat;
  final double lng;
  final String lead;
  final String leadType;
  final String leadSubType;
  final bool isReminder;
  final bool isSendEmail;
  final bool isSendSms;
  final bool isSendWhatsapp;
  final String mobile;
  final String countryCode;
  final bool notifyCustomer;
  final List<String> notifyUsers;
  final String leadStatus;
  final String? deadReason;
  final List<ProjectionProduct> projectionProducts;
  final List<String> productCategories;
  final DateTime? reminderDate;
  final String reminderTo;

  GlobalSettingCheckReqModel({
    required this.activity,
    required this.callStatus,
    required this.remark,
    required this.lat,
    required this.lng,
    required this.lead,
    required this.leadType,
    required this.leadSubType,
    required this.isReminder,
    required this.isSendEmail,
    required this.isSendSms,
    required this.isSendWhatsapp,
    required this.mobile,
    required this.countryCode,
    required this.notifyCustomer,
    required this.notifyUsers,
    required this.leadStatus,
    this.deadReason,
    required this.projectionProducts,
    required this.productCategories,
    this.reminderDate,
    required this.reminderTo,
  });

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'call_status': callStatus, // Changed from 'callStatus' to 'call_status'
      'remark': remark,
      'lat': lat,
      'lng': lng,
      'lead': lead,
      'lead_type': leadType, // Changed from 'leadType' to 'lead_type'
      'lead_sub_type': leadSubType, // Changed from 'leadSubType' to 'lead_sub_type'
      'is_reminder': isReminder, // Changed from 'isReminder' to 'is_reminder'
      'is_send_email': isSendEmail, // Changed from 'isSendEmail' to 'is_send_email'
      'is_send_sms': isSendSms, // Changed from 'isSendSms' to 'is_send_sms'
      'is_send_whatsapp': isSendWhatsapp, // Changed from 'isSendWhatsapp' to 'is_send_whatsapp'
      'mobile': mobile,
      'country_code': countryCode,
      'notify_customer': notifyCustomer, // Changed from 'notifyCustomer' to 'notify_customer'
      'notify_users': notifyUsers, // Changed from 'notifyUsers' to 'notify_users'
      'lead_status': leadStatus.toLowerCase(), // Changed from 'leadStatus' to 'lead_status' and lowercase
      'dead_reason': deadReason, // Changed from 'deadReason' to 'dead_reason'
      'projection_products': projectionProducts.map((p) => p.toJson()).toList(), // Changed from 'projectionProducts' to 'projection_products'
      'product_categories': productCategories, // Changed from 'productCategories' to 'product_categories'
      'reminder_date': reminderDate?.toIso8601String(), // Changed from 'reminderDate' to 'reminder_date'
      'reminder_to': reminderTo, // Changed from 'reminderTo' to 'reminder_to'
    };
  }

  GlobalSettingCheckReqModel copyWith({
    String? activity,
    String? callStatus,
    String? remark,
    double? lat,
    double? lng,
    String? lead,
    String? leadType,
    String? leadSubType,
    bool? isReminder,
    bool? isSendEmail,
    bool? isSendSms,
    bool? isSendWhatsapp,
    String? mobile,
    String? countryCode,
    bool? notifyCustomer,
    List<String>? notifyUsers,
    String? leadStatus,
    String? deadReason,
    List<ProjectionProduct>? projectionProducts,
    List<String>? productCategories,
    DateTime? reminderDate,
    String? reminderTo,
  }) {
    return GlobalSettingCheckReqModel(
      activity: activity ?? this.activity,
      callStatus: callStatus ?? this.callStatus,
      remark: remark ?? this.remark,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      lead: lead ?? this.lead,
      leadType: leadType ?? this.leadType,
      leadSubType: leadSubType ?? this.leadSubType,
      isReminder: isReminder ?? this.isReminder,
      isSendEmail: isSendEmail ?? this.isSendEmail,
      isSendSms: isSendSms ?? this.isSendSms,
      isSendWhatsapp: isSendWhatsapp ?? this.isSendWhatsapp,
      mobile: mobile ?? this.mobile,
      countryCode: countryCode ?? this.countryCode,
      notifyCustomer: notifyCustomer ?? this.notifyCustomer,
      notifyUsers: notifyUsers ?? this.notifyUsers,
      leadStatus: leadStatus ?? this.leadStatus,
      deadReason: deadReason ?? this.deadReason,
      projectionProducts: projectionProducts ?? this.projectionProducts,
      productCategories: productCategories ?? this.productCategories,
      reminderDate: reminderDate ?? this.reminderDate,
      reminderTo: reminderTo ?? this.reminderTo,
    );
  }
}

// Projection Product model
class ProjectionProduct {
  final String productCategory;
  final String product;
  final double amount;
  final DateTime projectionDate;

  ProjectionProduct({
    required this.productCategory,
    required this.product,
    required this.amount,
    required this.projectionDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_category': productCategory, // Changed from 'productCategory' to 'product_category'
      'product': product,
      'amount': amount,
      'projection_date': projectionDate.toIso8601String(), // Changed from 'projectionDate' to 'projection_date'
    };
  }
}