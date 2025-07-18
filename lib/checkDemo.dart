import 'package:flutter/material.dart';
import 'package:websuites/utils/common_responsive_list/common_responsive_list.dart';
import 'package:websuites/utils/reusable_validation/RequiredLabel.dart';
import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class CheckDemo extends StatefulWidget {
  const CheckDemo({super.key});

  @override
  State<CheckDemo> createState() => _CheckDemoState();
}

class _CheckDemoState extends State<CheckDemo> {
  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;

    final double fieldWidth = screenWidth < 600
        ? screenWidth * 0.9
        : (screenWidth - 0 - 5 * ((screenWidth / 550).floor() - 1)) /
        (screenWidth / 250).floor(); // Adjust for padding and spacing

    final double wrapSpacing = screenWidth < 550 ? 8 : 8;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Enhanced Form Layout"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Personal Information Section
            const Text(
              "Personal Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: wrapSpacing,
              runSpacing: 16,
              alignment: WrapAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequiredLabel(label: "First Name"),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Enter first name",
                        categories: ["Option 1", "Option 2", "Option 3", "Option 4"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Last Name",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Enter last name",
                        categories: ["Option 1", "Option 2", "Option 3", "Option 4"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequiredLabel(label: "Primary Email (Owner)"),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "john.doe@example.com",
                        categories: ["Option 1", "Option 2", "Option 3", "Option 4"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "DOB",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "dd/mm/yyyy",
                        categories: ["Option 1", "Option 2", "Option 3", "Option 4"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "RAM",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Enter RAM details",
                        categories: ["Option 1", "Option 2", "Option 3", "Option 4"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequiredLabel(label: "Primary Mobile (Owner)"),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "+91",
                        categories: ["Option 1", "Option 2", "Option 3", "Option 4"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Assigned To",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Choose assigned to",
                        categories: ["John Doe", "Jane Smith", "Mike Johnson", "Sarah Wilson"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Customer Type",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Select...",
                        categories: ["Individual", "Corporate", "Government", "SME"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Source",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Websites",
                        categories: ["Website", "Social Media", "Referral", "Advertisement"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequiredLabel(label: "Divisions"),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Select...",
                        categories: ["Sales", "Marketing", "Support", "Development"],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Address Information Section
            const Text(
              "Address Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: wrapSpacing,
              runSpacing: 16,
              alignment: WrapAlignment.spaceBetween, // Distribute fields evenly
              children: [
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "GST",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Enter GST",
                        categories: ["Option 1", "Option 2", "Option 3", "Option 4"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pincode",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Search Pincode...",
                        categories: ["Option 1", "Option 2", "Option 3", "Option 4"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "City",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Search City...",
                        categories: ["Option 1", "Option 2", "Option 3", "Option 4"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "District",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Select...",
                        categories: ["District 1", "District 2", "District 3", "District 4"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "State",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Select...",
                        categories: ["Punjab", "Delhi", "Maharashtra", "Gujarat", "Karnataka"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Address",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Enter address",
                        categories: ["Option 1", "Option 2", "Option 3", "Option  4"],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}