class GstListRequestModel {
  final int cgst;
  final int igst;
  final String name;
  final int sgst;
  final int status;

  GstListRequestModel({
    required this.cgst,
    required this.igst,
    required this.name,
    required this.sgst,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'cgst': cgst,
      'igst': igst,
      'name': name,
      'sgst': sgst,
      'status': status,
    };
  }
}
