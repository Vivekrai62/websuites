class LeadTrashRestoreResModel {
  LeadTrashRestoreResModel({
    required this.message,
    required this.result,
  });

  final String? message;
  final Result? result;

  factory LeadTrashRestoreResModel.fromJson(Map<String, dynamic> json){
    return LeadTrashRestoreResModel(
      message: json["message"],
      result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result?.toJson(),
  };

}

class Result {
  Result({
    required this.generatedMaps,
    required this.raw,
    required this.affected,
  });

  final List<dynamic> generatedMaps;
  final List<dynamic> raw;
  final int? affected;

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      generatedMaps: json["generatedMaps"] == null ? [] : List<dynamic>.from(json["generatedMaps"]!.map((x) => x)),
      raw: json["raw"] == null ? [] : List<dynamic>.from(json["raw"]!.map((x) => x)),
      affected: json["affected"],
    );
  }

  Map<String, dynamic> toJson() => {
    "generatedMaps": generatedMaps.map((x) => x).toList(),
    "raw": raw.map((x) => x).toList(),
    "affected": affected,
  };

}
