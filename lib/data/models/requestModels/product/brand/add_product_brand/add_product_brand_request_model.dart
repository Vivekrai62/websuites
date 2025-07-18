class AddProductBrandRequestModel {
  final String description;
  final String divisionId;
  final String name;

  AddProductBrandRequestModel({
    required this.description,
    required this.divisionId,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'division_id': divisionId,
      'name': name,
    };
  }
}
