class UpdateLeaveTypeRequestModel {
  String? id; // Keep this for API call
  String? name; // Nullable
  String? shortCode; // Nullable
  String? type; // Nullable
  String? description; // Nullable
  String isEmployeeView; // Non-nullable, required
  String isSickMedical; // Non-nullable, required
  String? limitGender; // Nullable

  UpdateLeaveTypeRequestModel({
    this.id, // Include id in the constructor
    this.name,
    this.shortCode,
    this.type,
    this.description,
    required this.isEmployeeView,
    required this.isSickMedical,
    this.limitGender,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'is_employee_view_description': isEmployeeView,
      'is_sick_leave': isSickMedical,
    };

    // Only add fields if they are not null
    if (name != null) data['name'] = name;
    if (shortCode != null) data['short_code'] = shortCode;
    if (type != null) data['type'] = type;
    if (description != null) data['description'] = description;
    if (limitGender != null) data['limit_gender'] = limitGender;

    return data;
  }
}