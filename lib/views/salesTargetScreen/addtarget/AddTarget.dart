import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../../resources/strings/strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../viewModels/leadScreens/createNewLead/assignedLeadTo/assigned_lead_to_viewModel.dart';
import '../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class AddTargetDialog extends StatefulWidget {
  const AddTargetDialog({super.key});

  @override
  _AddTargetDialogState createState() => _AddTargetDialogState();
}

class _AddTargetDialogState extends State<AddTargetDialog> {
  final AssignedLeadToViewModel _assignedLeadToController =
      Get.put(AssignedLeadToViewModel());
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _salesTargetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // customFieldsController.getIndustryType();

    // _assignedLeadToController
    //     .fetchAssignedLeads(context); // Ensure this is called

    // _divisionsController.createNewLeadDivisions(context);
    // productCategoryController.fetchLeadProductCategories(context); // Ensure this is called
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime initialDate = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AllColors.mediumPurple, // Header background color
              onPrimary: AllColors.whiteColor, // Header text color
              surface: AllColors.whiteColor, // Background color of calendar
              onSurface: AllColors.blackColor, // Text color of calendar
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  'Add Target',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Sale's Head member"),
              const SizedBox(height: 5),
              // Obx(() {
              //   if (_assignedLeadToController.loading.value) {
              //     return const CircularProgressIndicator();
              //   } else {
              //     return CreateNewLeadScreenCard(
              //       hintText: _assignedLeadToController.selectedLeadName.value.isEmpty
              //           ? Strings.select
              //           : _assignedLeadToController.selectedLeadName.value,
              //       categories: _assignedLeadToController.namesOnlyRxList,  // Use names only list
              //       onCategoryChanged: (selectedCategory) {
              //         // Handle selection for only first and last name
              //         final names = selectedCategory.split(' '); // Split by space
              //         if (names.length >= 2) {
              //           final firstName = names[0];
              //           final lastName = names[1];
              //           _assignedLeadToController.selectedLeadName.value = '$firstName $lastName';
              //         }
              //       },
              //     );
              //   }
              // }),

              const SizedBox(height: 15),
              const Text("Name"),
              const SizedBox(height: 5),
              const CommonTextField(
                hintText: 'Enter a target Name',
              ),
              const SizedBox(height: 20),
              const Text("Sales Target"),
              const SizedBox(height: 5),
              CommonTextField(
                hintText: '0',
                controller: _salesTargetController,
              ),
              const Text("amount: 0"),
              const SizedBox(height: 15),
              const Text("Start Date"),
              const SizedBox(height: 5),
              // CreateNewLeadScreenCard(
              //   hintText: 'Select start date',
              //   controller: _startDateController,
              //   isDateField: true, // Mark as a date field
              //   isLoading: false, // Set to true if loading
              //   prefixIcon: Icon(Icons.date_range,color: Colors.grey,size: 19,),
              //   suffixIcon: Icon(Icons.clear, color: Colors.grey, size: 19),
              //   onSuffixPressed: () {
              //     setState(() {
              //       _startDateController.clear(); // Clear the date
              //     });
              //   },
              // ),
              const SizedBox(height: 15),
              const Text("End Date"),
              const SizedBox(height: 5),
              // CreateNewLeadScreenCard(
              //   hintText: 'Select end date',
              //   controller: _endDateController,
              //   isDateField: true, // Mark as a date field
              //   prefixIcon: Icon(Icons.date_range,color: Colors.grey,size: 19,),
              //
              //   isLoading: false, // Set to true if loading
              //
              // ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColors.mediumPurple,
                    ),
                    onPressed: () {
                      // Validate and save logic
                      Navigator.of(context).pop();
                    },
                    child: const Text('Create',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _salesTargetController.dispose();
    super.dispose();
  }
}
