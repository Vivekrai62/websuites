class SalesDeleteBreakDownIncentiveResponseModel {
  List<Null>? raw;
  int? affected;

  SalesDeleteBreakDownIncentiveResponseModel({this.raw, this.affected});

  SalesDeleteBreakDownIncentiveResponseModel.fromJson(
      Map<String, dynamic> json) {
    if (json['raw'] != null) {
      raw = <Null>[];
      json['raw'].forEach((v) {
        raw!.add((v));
      });
    }
    affected = json['affected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (raw != null) {
      data['raw'] = raw!.map((v) => ()).toList();
    }
    data['affected'] = affected;
    return data;
  }
}
