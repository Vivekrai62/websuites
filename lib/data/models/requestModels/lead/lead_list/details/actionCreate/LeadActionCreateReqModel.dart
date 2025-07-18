class LeadActionCreateReqModel {
  LeadActionCreateReqModel({required this.json});
  final Map<String,dynamic> json;

  factory LeadActionCreateReqModel.fromJson(Map<String, dynamic> json){
    return LeadActionCreateReqModel(
        json: json
    );
  }

  Map<String, dynamic> toJson() => {
  };

}
