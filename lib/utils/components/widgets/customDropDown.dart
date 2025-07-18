import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../appColors/app_colors.dart';




// class BankListDataModel {
//   String bank_name;
//   String bank_logo;
//
//   BankListDataModel(this.bank_name, this.bank_logo);
// }

// class BankDropdownField extends StatefulWidget {
//   @override
//   _BankDropdownFieldState createState() => _BankDropdownFieldState();
// }

// class _BankDropdownFieldState extends State<BankDropdownField> {
//   BankListDataModel? _bankChoose;
//
//   List<BankListDataModel> bankDataList = [
//     BankListDataModel("SBI",
//         "https://www.kindpng.com/picc/m/83-837808_sbi-logo-state-bank-of-india-group-png.png"),
//     BankListDataModel("HDFC",
//         "https://www.pngix.com/pngfile/big/12-123534_download-hdfc-bank-hd-png-download.png"),
//     BankListDataModel("ICICI",
//         "https://www.searchpng.com/wp-content/uploads/2019/01/ICICI-Bank-PNG-Icon-715x715.png"),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _bankChoose = bankDataList[0];
//   }
//
//   void _onDropDownItemSelected(BankListDataModel? newSelectedBank) {
//     setState(() {
//       _bankChoose = newSelectedBank;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         child: Center(
//           child: Container(
//             margin: EdgeInsets.only(left: 15, top: 10, right: 15),
//             child: FormField<String>(
//               builder: (FormFieldState<String> state) {
//                 return InputDecorator(
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(12, 10, 20, 20),
//                     errorText: _bankChoose == null ? "Wrong Choice" : null,
//                     errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<BankListDataModel>(
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey,
//                         fontFamily: "verdana_regular",
//                       ),
//                       hint: Text(
//                         "Select Bank",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 16,
//                           fontFamily: "verdana_regular",
//                         ),
//                       ),
//                       items: bankDataList.map((BankListDataModel value) {
//                         return DropdownMenuItem(
//                           value: value,
//                           child: Row(
//                             children: [
//                               CircleAvatar(
//                                 backgroundImage: NetworkImage(value.bank_logo),
//                               ),
//                               SizedBox(width: 15),
//                               Text(value.bank_name),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                       isExpanded: true,
//                       isDense: true,
//                       onChanged: (BankListDataModel? newSelectedBank) {
//                         _onDropDownItemSelected(newSelectedBank);
//                       },
//                       value: _bankChoose,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }





class CustomDropdown extends StatelessWidget {
  final bool isLoading;
  final String errorMessage;
  final List<dynamic> items;
  final dynamic selectedValue;
  final Function(dynamic) onChanged;
  final String hintText;
  const CustomDropdown({
    super.key,
    required this.isLoading,
    required this.errorMessage,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    } else if (errorMessage.isNotEmpty) {
      return Text(
        errorMessage,
        style: const TextStyle(color: Colors.red),
      );
    } else {
      return Container(
        height: Get.height / 15, // Match the height of the text field
        width: Get.width, // Use full width or adjust as needed
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<dynamic>(
            isExpanded: true,
            dropdownColor: Colors.white,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 21,
                color: Colors.grey.shade400,
              ),
            ),
            value: selectedValue,
            items: items.map((source) {
              final isSelected = selectedValue == source['id'];
              return DropdownMenuItem<String>(
                value: source['id'],
                child: Container(
                  height: kMinInteractiveDimension, // Use the minimum interactive dimension
                  width: Get.width * 0.8, // Reduced width for the dropdown
                  alignment: Alignment.centerLeft,
                  color:  isSelected ? AllColors.mediumPurple : Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      source['name'] ?? '',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 16, // Reduced font size
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            selectedItemBuilder: (BuildContext context) {
              return items.map<Widget>((dynamic item) {
                return Container(
                  color: Colors.transparent,
                  child: Text(
                    item['name'] ?? '',
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList();
            },

            isDense: true,
            menuMaxHeight: Get.height * 0.3, // Limit the height of the dropdown menu
          ),
        ),
      );
    }
  }
}




