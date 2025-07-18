class AddMasterProposalRequestModel {
  String? subject;
  String? body;
  String? attachment;

  AddMasterProposalRequestModel({this.subject, this.body, this.attachment});

  AddMasterProposalRequestModel.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    body = json['body'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = subject;
    data['body'] = body;
    data['attachment'] = attachment;
    return data;
  }
}
