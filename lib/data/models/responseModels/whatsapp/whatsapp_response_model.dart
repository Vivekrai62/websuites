class WhatsappResponseModel{
  String? id;
  String? lastWhatsappMessage;
  String? lastWhatsappMessageDate;
  int? unreadWhatsappMessages;
  String? lead;
  Customer? customer;
  String? name;
  String? mobile;
  String? type;

  WhatsappResponseModel({
    this.id,
    this.lastWhatsappMessage,
    this.lastWhatsappMessageDate,
    this.lead,
    this.name,
    this.type,
    this.customer,
    this.mobile,
    this.unreadWhatsappMessages
});

  WhatsappResponseModel.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    lastWhatsappMessage = json['lastWhatsappMessage'];
    lastWhatsappMessageDate = json['lastWhatsappMessageDate'];
    lead = json['lead'];
    name = json['name'];
    type = json['type'];
    customer = json['customer'];
    mobile = json['mobile'];
    unreadWhatsappMessages = json['unreadWhatsappMessages'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['lastWhatsappMessage'] = lastWhatsappMessage;
    data['lastWhatsappMessageDate'] = lastWhatsappMessageDate;
    data['lead'] = lead;
    data['name'] = name;
    data['type'] = type;
    data['customer'] = customer;
    data['mobile'] = mobile;
    data['unreadWhatsappMessages'] = unreadWhatsappMessages;
    return data;
  }
}

class Customer{
  String? id;

  Customer({this.id});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    return data;
  }
}