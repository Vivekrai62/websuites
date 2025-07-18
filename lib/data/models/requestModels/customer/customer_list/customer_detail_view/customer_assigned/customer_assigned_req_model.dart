class CustomerAssignedReqModel {
  List<String>? customer;

  CustomerAssignedReqModel({this.customer});

  CustomerAssignedReqModel.fromJson(Map<String, dynamic> json) {
    customer = json['customer'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer'] = this.customer;
    return data;
  }
}
