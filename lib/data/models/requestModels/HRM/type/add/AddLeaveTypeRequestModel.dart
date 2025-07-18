class AddLeaveTypeRequestModel {
  String? name;
  String? shortCode;
  String? type;
  String? description;
  bool? isEmployeeView;  // This is your original field
  bool? isSickMedical;    // This should be a boolean
  bool? isEmployeeViewDescription; // Add this line
  String? limitGender;

  AddLeaveTypeRequestModel({
    this.name,
    this.shortCode,
    this.type,
    this.description,
    this.isEmployeeView,
    this.isSickMedical,
    this.isEmployeeViewDescription,
    this.limitGender
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'short_code': shortCode,
      'type': type,
      'description': description,
      'is_employee_view_description': isEmployeeViewDescription ?? false,
      'is_sick_leave': isSickMedical ?? false, // Ensure this is a boolean
      'limitGender': limitGender
    };
  }
}