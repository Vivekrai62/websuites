
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:websuites/utils/components/widgets/drawer/custom_drawer.dart';
// import 'package:websuites/viewModels/leadScreens/createNewLead/assignedLeadTo/assigned_lead_to_viewModel.dart';
// import 'package:websuites/viewModels/leadScreens/createNewLead/customFields/custom_fields_viewModels.dart';
// import 'package:websuites/viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
// import 'package:websuites/viewModels/leadScreens/createNewLead/source/source_view_model.dart';
// import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
// import '../../../data/models/responseModels/login/login_response_model.dart';
// import '../../../resources/iconStrings/icon_strings.dart';
// import '../../../resources/strings/strings.dart';
// import '../../../resources/textStyles/text_styles.dart';
// import '../../../utils/appColors/app_colors.dart';
// import '../../../utils/components/widgets/appBar/custom_appBar.dart';
// import '../../../utils/components/widgets/navBar/custom_navBar.dart';
// import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
// import '../../../utils/components/widgets/sizedBoxes/sizedBox_15h.dart';
// import '../../../utils/responsive/responsive_layout.dart';
// import '../../../viewModels/saveToken/save_token.dart';
// class CreateNNewLeadScreen extends StatefulWidget {
//   const CreateNNewLeadScreen({super.key});
//   @override
//   State<CreateNNewLeadScreen> createState() => _CreateNNewLeadScreenState();
// }
// class _CreateNNewLeadScreenState extends State<CreateNNewLeadScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final AssignedLeadToViewModel _assignedLeadToController = Get.put(AssignedLeadToViewModel());
//   final DivisionsViewModel _divisionsController = Get.put(DivisionsViewModel());
//   final CreateLeadCustomFieldsViewModel customFieldsController = Get.put(CreateLeadCustomFieldsViewModel());
//   final SourceViewModel  sourceViewModel=Get.put(SourceViewModel());
//   final SaveUserData userPreference = SaveUserData();
//   String userName = '';
//   String? userEmail = '';
//   // final LeadSourceController _leadSourceController = Get.put(LeadSourceController(apiService: NetworkApiServices()));
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//     _initControllers();
//     sourceViewModel.sourceList=[
//       "Name",
//       "id",
//       "House",
//       "data"
//     ];
//   }
//
//   void _initControllers() {
//     // _assignedLeadToController.assignedLead(context);
//     _divisionsController.createNewLeadDivisions(context);
//     customFieldsController.createNewLeadCustomFields(context);
//     // _leadSourceController.fetchLeadSources(AppUrls.createNewLeadSource);
//   }
//
//   Future<void> fetchUserData() async {
//     try {
//       LoginResponseModel response = await userPreference.getUser();
//       setState(() {
//         userName = response.user?.first_name ?? '';
//         userEmail = response.user?.email ?? '';
//       });
//     } catch (e) {
//       print('Error fetching userData: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveScaffold(
//       scaffoldKey: _scaffoldKey,
//       bottomNavigationBar: CustomBottomNavBar(),
//       floatingActionButton: CustomFloatingButton(
//         onPressed: () {},
//         imageIcon: IconStrings.navSearch3,
//         backgroundColor: AllColors.mediumPurple,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       backgroundColor: AllColors.whiteColor,
//       drawer: CustomDrawer(
//         userName: userName,
//         phoneNumber: userEmail ?? '',
//         version: '1.0.12',
//       ),
//       body: Stack(
//         children: [
//           _buildScrollableContent(),
//          _buildCustomAppBar(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildScrollableContent() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 140),
//             _buildStandardFields(),
//             const SizedBox(height: 30),
//             _buildCustomFields(),
//             const SizedBox(height: 100),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStandardFields() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextStyles.w600_15(color: AllColors.vividPurple, context, Strings.standardFields),
//         const SizedBox(height: 28),
//         _buildInputField(Strings.firstName, Strings.enterFirstName),
//         _buildInputField(Strings.lastName, Strings.enterLastName),
//         // _buildPhoneNumberField(),
//         // _buildEmailField(),
//         _buildInputField(Strings.address, Strings.enterAddress),
//         _buildInputField(Strings.city, Strings.city),
//         _buildInputField(Strings.state, Strings.state),
//         _buildInputField(Strings.country, Strings.country),
//         _buildSourceField(),
//         _buildInputField(Strings.assignedLeadTo, Strings.assignedLeadTo),
//         _buildInputField(Strings.organisation, Strings.enterName),
//         _buildInputField(Strings.divisions, Strings.select),
//         _buildInputField(Strings.categories, Strings.select),
//         // _buildRequirementField(),
//       ],
//     );
//   }
//
//   Widget _buildCustomFields() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextStyles.w600_universal(fontSize: 15, color: AllColors.vividPurple, context, Strings.customFields),
//         const SizedBox(height: 30),
//         _buildInputField(Strings.pincode, Strings.enterPincode),
//         _buildInputField(Strings.designation, Strings.select),
//         _buildInputField(Strings.website, Strings.website),
//         _buildInputField(Strings.gstNumber, Strings.gstNumber),
//         _buildInputField(Strings.customerDivision, Strings.select),
//         _buildInputField(Strings.industryType, Strings.select),
//         _buildInputField(Strings.leadCategory, Strings.select),
//         _buildInputField(Strings.contactPersonName, Strings.enterContactPersonName),
//         _buildInputField(Strings.contactPersonNumber, Strings.enterContactPersonNumber),
//         _buildInputField(Strings.completeAddress, Strings.enterAddress),
//         _buildInputField(Strings.industry, Strings.createNewLeadSelect),
//         const SizedBox(height: 30),
//         // _buildActionButtons(),
//       ],
//     );
//   }
//
//   Widget _buildInputField(String label, String hintText) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextStyles.w500_14_Black(context, label),
//         CreateNewLeadScreenCard(hintText: hintText),
//         SizedBox15h(),
//       ],
//     );
//   }
//
//   Widget _buildSourceField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextStyles.w500_14_Black(context, Strings.source),
//         // Obx(() {
//         //   if (_leadSourceController.isLoading.value) {
//         //     return CircularProgressIndicator();
//         //   }
//         //   else if (_leadSourceController.errorMessage.isNotEmpty) {
//         //     return Text(_leadSourceController.errorMessage.value,
//         //         style: TextStyle(color: Colors.red));
//         //   }
//         //   else {
//         //     return
//         Container(
//               margin: const EdgeInsets.only(top: 5),
//               height: Get.height / 21,
//               decoration: BoxDecoration(
//                 border: Border.all(color: AllColors.lightGrey, width: 0.3),
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: DropdownButtonFormField<dynamic>(
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 ),
//                 hint: Text(Strings.source,
//                     style: TextStyle(fontSize: 13, color: AllColors.lighterGrey)),
//                 items: sourceViewModel.sourceList.map((source) {
//                   return DropdownMenuItem(
//                     value: source,
//                     child: Text(source?? ''),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   // Handle the selection
//                 },
//               ),
//             ),
//         // }),
//         // SizedBox15h(),
//       ],
//     );
//   }
//
//   // ... rest of the widget methods ...
//
//   Widget _buildCustomAppBar() {
//     return CustomAppBar(
//       child: Row(
//         children: [
//           if (MediaQuery.of(context).size.width < 500) ...[
//             InkWell(
//               onTap: () => _scaffoldKey.currentState?.openDrawer(),
//               child: Icon(Icons.menu, size: 25, color: AllColors.blackColor),
//             ),
//             const SizedBox(width: 10),
//           ],
//           TextStyles.w700_16(color: AllColors.blackColor, context, Strings.createNewLead),
//           const Spacer(),
//           Container(
//             height: Get.height / 28,
//             width: Get.width / 3.4,
//             decoration: BoxDecoration(
//               color: AllColors.mediumPurple,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Icon(Icons.cloud_download_sharp, size: 15, color: AllColors.whiteColor),
//                 TextStyles.w400_14(color: AllColors.whiteColor, context, Strings.importLeads),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }