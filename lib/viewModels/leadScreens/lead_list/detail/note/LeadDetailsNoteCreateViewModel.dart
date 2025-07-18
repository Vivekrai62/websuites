import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/lead/lead_list/details/activities/note/LeadDetailsNoteCreateReqMode.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadDetailsNoteCreateViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> leadDetailsActivitiesNotesCreate({
    required String remark,
    required String leadId,
    bool isSendEmail = false,
    bool isSendSms = false,
    bool isSendWhatsapp = false,
    String? activity,
    double? lat,
    double? lng,
  }) async {
    loading.value = true;

    final request = LeadDetailsNoteCreateReqMode(
      remark: remark,
      lead: leadId,
      isSendEmail: isSendEmail,
      isSendSms: isSendSms,
      isSendWhatsapp: isSendWhatsapp,
      activity: activity,
      lat: lat,
      lng: lng,
    );

    try {
      final value = await _api.leadDetailsActivitiesNotesCreate(request.toJson());
      if (value.message?.isNotEmpty ?? false) {
        if (kDebugMode) {
          print("Lead Detail Note Create: ${value.message}");
        }
        Utils.snackbarSuccess('Note created successfully');
      } else {
        Utils.snackbarFailed('Failed to create note: Empty response');
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error creating note: $error");
      }
      Utils.snackbarFailed('Failed to create note: $error');
    } finally {
      loading.value = false;
    }
  }
}