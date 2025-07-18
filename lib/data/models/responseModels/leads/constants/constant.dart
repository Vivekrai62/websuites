class ConstantsResponseModel {
  final String? newValue;
  final  String? inProgress;
  final  String? converted;
  final  String? dead;
  final  String? withteam;
  final  String? individual;
  final String? createDate;
  final String? activityDate;
  final String? assignDate;
  String? running;
  String? noServices;
  String? desc;
  String? asc;
  String? all;
  String? repeated;
  String? nonRepeated;
  String? orderDesc;
  String? orderAsc;
  String? toDoNeedAction;
  String? toDoActionTaken;
  String? queryTypeDirect;
  String? queryTypeBuy;
  String? queryTypeCall;
  String? assignTypeAssigned;
  String? assignTypeUnassigned;
  String? assignTypeAssignFresh;
  String? assignTypeUnAssignFresh;
  String? reAssigned;
  String unHandleLeads;
  String foreignLeads;
  String leadsWithoutCampaign;
  String?active;
  String?inActive;





  String? reUnAssigned;
  String? reminderTypeToday;
  String? reminderTypeMissed;
  String? reminderTypeUpcoming;
  String? reminderTypeTodayMissed;
  String? repeatTypeAll;
  String? repeatTypeRepeat;
  String? repeatTypeNonRepeated;
  String? activityRangeStartDays;
  String? activityRangeSecond;
  String? activityRangeThird;
  String? activityRangeFour;
  String? activityRangeFifth;
  String?  activityRangeSix;
  String?  activityRangeSeven;
  String? detailActivityCall;
  String? detailActivityMeeting;
  String? detailActivityCallLeadType;
  String? detailActivityCallLeadStatus;
  String? detailActivityCallReminder;
  String? detailActivityCallNote;
  String? detailActivityCallProposal;
  String? detailActivityCallServices;
  String? noActivityCall;
  String ?noActivityOrder;
  String? noActivityMeeting;
  String?notStarted;
  String?onHold;
  ConstantsResponseModel(
      {

        required  this.newValue,
        required  this.inProgress,
        required  this.converted,
        required  this.dead,
        required  this.withteam,
        required  this.individual,
        required  this.createDate,
        required  this.assignDate,
        required  this.activityDate,
        required this.leadsWithoutCampaign,
        required this.unHandleLeads,
        required this.foreignLeads,
        this.notStarted,
        this.onHold,
        this.active,
        this.inActive,
        this.running,
        this.noServices,
        this.desc,
        this.asc,
        this.all,
        this.repeated,
        this.nonRepeated,
        this.orderDesc,
        this.orderAsc,
        this.toDoNeedAction,
        this.toDoActionTaken,
        this.queryTypeDirect,
        this.queryTypeBuy,
        this.queryTypeCall,
        this.assignTypeAssigned,
        this.assignTypeUnassigned,
        this.assignTypeAssignFresh,
        this.assignTypeUnAssignFresh,
        this.reAssigned,
        this.reUnAssigned,
        this.reminderTypeToday,
        this.reminderTypeMissed,
        this.reminderTypeUpcoming,
        this.reminderTypeTodayMissed,
        this.activityRangeStartDays,
        this.activityRangeSecond,
        this.activityRangeThird,
        this.activityRangeFour,
        this.activityRangeFifth,
        this.activityRangeSix,
        this.activityRangeSeven,
        this.detailActivityCall,
        this.detailActivityMeeting,
        this.detailActivityCallLeadType,
        this.detailActivityCallLeadStatus,
        this.detailActivityCallReminder,
        this.detailActivityCallNote,
        this.detailActivityCallProposal,
        this.detailActivityCallServices,
        this.noActivityCall,
        this.noActivityOrder,
        this.noActivityMeeting,

      });
}
