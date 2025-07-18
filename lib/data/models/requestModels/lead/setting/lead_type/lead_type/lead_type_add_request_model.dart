class AddLeadTypeReqModel {
  String? name;
  bool? isReminderRequired;
  bool? removeFromList;
  bool? removeFromTodo;

  AddLeadTypeReqModel(
      {this.name,
        this.isReminderRequired,
        this.removeFromList,
        this.removeFromTodo});

  AddLeadTypeReqModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isReminderRequired = json['isReminderRequired'];
    removeFromList = json['remove_from_list'];
    removeFromTodo = json['remove_from_todo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isReminderRequired'] = this.isReminderRequired;
    data['remove_from_list'] = this.removeFromList;
    data['remove_from_todo'] = this.removeFromTodo;
    return data;
  }
}
