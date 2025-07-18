class IncentiveBreakDownUpdateRequestModel {
  final int achievePercentage;
  final int incentive;
  final String incentiveType;
  final String targetIncentiveMember;

  IncentiveBreakDownUpdateRequestModel({
    required this.achievePercentage,
    required this.incentive,
    required this.incentiveType,
    required this.targetIncentiveMember,
  });

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      "achieve_percentage": achievePercentage,
      "incentive": incentive,
      "incentive_type": incentiveType,
      "target_incentive_member": targetIncentiveMember,
    };
  }

  // Create a model from JSON
  factory IncentiveBreakDownUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    return IncentiveBreakDownUpdateRequestModel(
      achievePercentage: json["achieve_percentage"],
      incentive: json["incentive"],
      incentiveType: json["incentive_type"],
      targetIncentiveMember: json["target_incentive_member"],
    );
  }
}
