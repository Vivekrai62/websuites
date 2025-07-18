import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/responseModels/leads/constants/constant.dart';

class ConstantValueViewModel extends GetxController{

  RxList<ConstantsResponseModel>constantList=<ConstantsResponseModel>[].obs;



  fetchConstantList(BuildContext context){
    constantList.value=[
      ConstantsResponseModel(
          newValue: "New",
          inProgress: "In Progress",
          converted: "Converted",
          dead: "Dead",
          orderDesc: "Order Descending",
          orderAsc: "Order Ascending",
          toDoNeedAction: "Need Action",
          toDoActionTaken: "Action Taken",
          queryTypeDirect: "Direct",
          queryTypeBuy: "Buy Lead",
          queryTypeCall: "Call",
          assignTypeAssigned: "Assigned",
          assignTypeUnassigned: "Unassigned",
          assignTypeAssignFresh: "Assigned Fresh",
          assignTypeUnAssignFresh: "UnAssigned Fresh",
          reAssigned: "Reassigned",
          reUnAssigned: "Re-Unassigned",
          reminderTypeToday: "Today",
          reminderTypeMissed: "Missed",
          reminderTypeUpcoming: "Upcoming",
          reminderTypeTodayMissed: "Today+Missed",
          noServices: "No Services",
          running: "Running",
          active: "Active",
          inActive: "Inactive",
          notStarted: "Not Stared",
          onHold: "On Hold",

          activityRangeStartDays: "0-7 days",
          activityRangeSecond: "8-14 days",
          activityRangeThird: "15-21 days",
          activityRangeFour: "22-31 days",
          activityRangeFifth: "31-60 days",
          activityRangeSix: "61-90 days",
          activityRangeSeven: "90+ days",

         desc: "DESC",
          asc: "ASC",
          foreignLeads:"Foreign Leads" ,
          leadsWithoutCampaign: "Leads Without Campaign",
          unHandleLeads: "Un-Handle Leads",


          detailActivityCall: "Call",
          detailActivityMeeting: "Meeting",
          detailActivityCallLeadType: "Lead Type",
          detailActivityCallLeadStatus: "Lead Status",
          detailActivityCallReminder: "Reminder",
          detailActivityCallNote: "Note",
          detailActivityCallProposal: "Proposal",
          detailActivityCallServices: "Services",
          noActivityCall: " Call",
          noActivityOrder: " Order ",
          noActivityMeeting: " Meeting",
          withteam: 'With Team',
          individual: 'Individual',
          createDate: 'Create Date',
          activityDate: 'Activity Date',
          assignDate: 'Assigned Date',
          all:'All',
          repeated: 'Repeated',
          nonRepeated: 'Non-Repeated,'


      ),
    ];
  }


}