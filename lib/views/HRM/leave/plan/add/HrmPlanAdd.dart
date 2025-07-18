import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../utils/appColors/app_colors.dart';
import '../../../../../utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import '../../../../../utils/button/CustomButton.dart';
import '../../../../../utils/fontfamily/FontFamily.dart';

class HrmPlanDiliouge extends StatefulWidget {
  const HrmPlanDiliouge({super.key});

  @override
  _HrmPlanDiliougeState createState() => _HrmPlanDiliougeState();
}

class _HrmPlanDiliougeState extends State<HrmPlanDiliouge> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  // Function to show DatePicker in a dialog
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2100);

    // Show the date picker inside a dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Date'),
          content: SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialDate,
              minimumDate: firstDate,
              maximumDate: lastDate,
              onDateTimeChanged: (DateTime newDateTime) {
                controller.text =
                    "${newDateTime.toLocal()}".split(' ')[0]; // Format the date
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Update Leave Type',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AllColors.blackColor,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Leave Type Field
          const Text('Leave Plan Name *'),
          const SizedBox(height: 5),
          const CreateNewLeadScreenCard2(
            hintText: 'Ok',
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Start Date *'),
                    CreateNewLeadScreenCard2(
                      isDateField: true,
                      hintText: 'Start Date',
                      controller: startDateController, // Assign controller here
                      onTap: () => _selectDate(context, startDateController),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('End Date *'),
                    CreateNewLeadScreenCard2(
                      isDateField: true,
                      hintText: 'End Date',
                      controller: endDateController, // Assign controller here
                      onTap: () => _selectDate(context, endDateController),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Description *'),
          const SizedBox(height: 5),
          const CreateNewLeadScreenCard2(
            hintText: 'Description',
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              CustomButton(
                height: Get.height / 28,
                width: 100,
                backgroundColor: AllColors.greyGoogleForm,
                child: Text(
                  'Choose files',
                  style: TextStyle(color: AllColors.blackColor, fontSize: 12),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 9.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'No file selected',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                width: 80,
                height: 30,
                borderRadius: 25,
                onPressed: () {
                  // Handle update action
                  // You could add any save or update logic here
                },
                child: const Text(
                  'Update',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.sfPro,
                  ),
                ),
              ),
              CustomButton(
                backgroundColor: AllColors.textField,
                width: 80,
                height: 30,
                borderRadius: 25,
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.sfPro,
                    color: AllColors.blackColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
