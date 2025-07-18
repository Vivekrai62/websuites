class CustomerOrderlessServiceRenewResponseModel {
  String? startDate;
  String? endDate;
  String? remark;
  String? reminderBeforeExpire;
  Product? product;
  Product? company;
  Product? startBy;
  Product? createdBy;
  Null quitReason;
  Null quitDate;
  String? id;
  bool? status;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  bool? isDisposed;

  CustomerOrderlessServiceRenewResponseModel(
      {this.startDate,
      this.endDate,
      this.remark,
      this.reminderBeforeExpire,
      this.product,
      this.company,
      this.startBy,
      this.createdBy,
      this.quitReason,
      this.quitDate,
      this.id,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isDisposed});

  CustomerOrderlessServiceRenewResponseModel.fromJson(
      Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    remark = json['remark'];
    reminderBeforeExpire = json['reminder_before_expire'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    company =
        json['company'] != null ? Product.fromJson(json['company']) : null;
    startBy =
        json['start_by'] != null ? Product.fromJson(json['start_by']) : null;
    createdBy = json['created_by'] != null
        ? Product.fromJson(json['created_by'])
        : null;
    quitReason = json['quit_reason'];
    quitDate = json['quit_date'];
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isDisposed = json['isDisposed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['remark'] = remark;
    data['reminder_before_expire'] = reminderBeforeExpire;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (startBy != null) {
      data['start_by'] = startBy!.toJson();
    }
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    data['quit_reason'] = quitReason;
    data['quit_date'] = quitDate;
    data['id'] = id;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['isDisposed'] = isDisposed;
    return data;
  }
}

class Product {
  String? id;

  Product({this.id});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
