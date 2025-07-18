import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/responseModels/leads/static_value/static_value.dart';

class StaticViewModel extends GetxController{

  RxList<StaticValueModel>staticList=<StaticValueModel>[].obs;

  fetchList(BuildContext context){
    var data= StaticValueModel(
      leadList: LeadList(
        todo: ["Need Action", "Take Action"],
        queryType: ["Direct", "Buy Lead", "Call"],
      ),
      leadActivity: LeadActivity(
        daily: Daily(
          byActivity: ["Call", "Meeting", "LeadType"],
          noActivities: NoActivities(
            forActivities: ["Call", "Order", "Meeting"],
            activitySince: ["7 days", "15 days", "21 Day", "4 Days"],
          ),
        ),
      ),
    ).obs;
    if (kDebugMode) {
      print("Static LeadList todo ${data.value.leadList.todo}");
    }
    if (kDebugMode) {
      print("Static LeadList queryType${data.value.leadList.queryType}");
    }

}


}