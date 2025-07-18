class DbTransactionResModel {
  DbTransactionResModel({
    required this.total,
    required this.data,
  });

  final int? total;
  final List<Datum> data;

  factory DbTransactionResModel.fromJson(Map<String, dynamic> json){
    return DbTransactionResModel(
      total: json["total"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.amount,
    required this.currencyAmount,
    required this.conversionRate,
    required this.paymentMode,
    required this.entryType,
    required this.txnId,
    required this.chequeNumber,
    required this.chequeDate,
    required this.paymentDate,
    required this.uploadDocument,
    required this.invoice,
    required this.information,
    required this.isFresh,
    required this.isFirst,
    required this.status,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.gstAndFees,
    required this.paymentType,
  });

  final String? id;
  final int? amount;
  final int? currencyAmount;
  final int? conversionRate;
  final String? paymentMode;
  final String? entryType;
  final String? txnId;
  final int? chequeNumber;
  final dynamic chequeDate;
  final dynamic paymentDate;
  final String? uploadDocument;
  final dynamic invoice;
  final String? information;
  final bool? isFresh;
  final bool? isFirst;
  final String? status;
  final String? remark;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? gstAndFees;
  final String? paymentType;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      amount: json["amount"],
      currencyAmount: json["currency_amount"],
      conversionRate: json["conversion_rate"],
      paymentMode: json["payment_mode"],
      entryType: json["entry_type"],
      txnId: json["txn_id"],
      chequeNumber: json["cheque_number"],
      chequeDate: json["cheque_date"],
      paymentDate: json["payment_date"],
      uploadDocument: json["upload_document"],
      invoice: json["invoice"],
      information: json["information"],
      isFresh: json["is_fresh"],
      isFirst: json["is_first"],
      status: json["status"],
      remark: json["remark"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      gstAndFees: json["gst_and_fees"],
      paymentType: json["payment_type"],
    );
  }

}

