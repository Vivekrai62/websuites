import 'package:flutter/material.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class PracticeScreen extends StatefulWidget {
  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, bool> expandedSections = {
    'items': true,
    'orderSummary': true,
    'customerInfo': true,
    'orderDetails': true,
    'company': true,
    'currency': true,
    'salesPerson': true,
    'uploadPerforma': true,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void toggleSection(String section) {
    setState(() {
      expandedSections[section] = !expandedSections[section]!;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 8, 16, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios, size: 24, color: Color(0xFF6B7280)),
                SizedBox(width: 12),
                Text(
                  'Create Order',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: AllColors.mediumPurple, width: 2),
                insets: EdgeInsets.zero,
              ),
              labelColor: AllColors.mediumPurple,
              unselectedLabelColor: Color(0xFF6B7280),
              labelStyle: TextStyle(fontWeight: FontWeight.w500),
              tabs: [
                Tab(text: 'Order Details'),
                Tab(text: 'Payments'),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrderDetailsTab(),
                _buildPaymentsTab(),
              ],
            ),
          ),


          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
            ),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF16A34A),
                  minimumSize: Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetailsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          _buildItemsSection(),
          SizedBox(height: 16),
          _buildOrderSummarySection(),
          SizedBox(height: 16),
          _buildOrderDateSection(),
          SizedBox(height: 16),
          _buildCustomerInfoSection(),
          SizedBox(height: 16),
          _buildCompanySection(),
          SizedBox(height: 16),
          _buildCurrencySection(),
          SizedBox(height: 16),
          _buildSalesPersonSection(),
          SizedBox(height: 16),
          _buildUploadPerformaSection(),

        ],
      ),
    );
  }

  Widget _buildPaymentsTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200, // Reduced height for the placeholder
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.payments_outlined,
                    size: 48, // Slightly smaller icon
                    color: Color(0xFFD1D5DB),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'No Payments',
                    style: TextStyle(
                      fontSize: 16, // Slightly smaller font
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Add your first payment to get started',
                    style: TextStyle(
                      fontSize: 12, // Smaller font
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      minimumSize: Size(120, 36), // Smaller button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Make Payment',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100), // Space to ensure button visibility
          ],
        ),
      ),
    );
  }

  Widget _buildCollapsibleSection({
    required String title,
    required String section,
    required Widget child,
  }) {
    return ContainerUtils(
      paddingBottom: 0,
      paddingTop: 0,
      paddingRight: 0,
      paddingLeft: 0,

      child: Column(
        children: [
          InkWell(
            onTap: () => toggleSection(section),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  Icon(
                    expandedSections[section]!
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Color(0xFF6B7280),
                  ),
                ],
              ),
            ),
          ),
          if (expandedSections[section]!)
            child,

        ],
      ),
    );
  }

  Widget _buildItemsSection() {
    return _buildCollapsibleSection(
      title: 'Items',
      section: 'items',
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.shrink(),
                Row(
                  children: [
                    Icon(Icons.add, size: 16, color: Color(0xFF2563EB)),
                    SizedBox(width: 4),
                    Text(
                      'Add new item',
                      style: TextStyle(
                        color: Color(0xFF2563EB),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'You Can Add Items Behalf of Division',
              style: TextStyle(
                fontSize: 13,
                color:AllColors.grey,
              ),
            ),
            SizedBox(height: 16),
        CommonTextField(hintText: 'Select',categories: [ "hello"],),
            SizedBox(height: 16),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE5E7EB)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.web,
                          color: Color(0xFFF59E0B),
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Landing Page Website',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            Text(
                              'Free (No Charges)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF16A34A),
                              ),
                            ),
                            Text(
                              'Serviceable • Duration: 13-05-2025 to 13-05-2025',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Text(
                              'Quantity',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                            Text(
                              '1',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'GST',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                            Text(
                              '0',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Received',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF16A34A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                            Text(
                              '₹0',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummarySection() {
    return _buildCollapsibleSection(
      title: 'Order Invoice Detail',
      section: 'orderSummary',
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15,right: 15,left: 15),
        child: Column(
          children: [
            _buildAmountRow('Sub Total Amount', '₹0'),
            _buildAmountRow('GST Amount', '₹0'),
            _buildAmountRow('Total Amount', '₹0'),
            _buildAmountRow('Received Amount', '₹0'),
            Divider(thickness: 1, color: Color(0xFFE5E7EB)),
            _buildAmountRow('Due Amount', '₹0', isBold: true),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF3F4F6),
                foregroundColor: Color(0xFF2563EB),
                minimumSize: Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('update TDS'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountRow(String label, String amount, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14,
              color: isBold ? Color(0xFF1F2937) : Color(0xFF1F2937),
              fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDateSection() {
    return _buildCollapsibleSection(

      title: 'Order Date',
      section: 'orderDetails',
      child: Text(
        '13-05-2025, 01:00 PM',
        style: TextStyle(color: Color(0xFF1F2937)),
      ),
    );
  }

  Widget _buildCustomerInfoSection() {
    return _buildCollapsibleSection(
      title: 'Customer Info',
      section: 'customerInfo',
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.person_outline, 'Amit Kumar'),
            _buildInfoRow(Icons.phone_outlined, '9876543210'),
            _buildInfoRow(Icons.location_on_outlined, 'not available!',
                color: Color(0xFF6B7280)),
            SizedBox(height: 12),
            Divider(thickness: 1, color: Color(0xFFE5E7EB)),
            SizedBox(height: 12),
            Text(
              'Gstin No.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Customer Since',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF6B7280)),
                SizedBox(width: 8),
                Text(
                  'Mon Apr 21 2025',
                  style: TextStyle(color: Color(0xFF1F2937)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanySection() {
    return _buildCollapsibleSection(
      title: 'Company',
      section: 'company',
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
        child: Column(
          children: [
            _buildInfoRow(Icons.business_outlined, 'Amit Industries'),
            _buildInfoRow(Icons.email_outlined, 'amitkumar@test.com'),
            _buildInfoRow(Icons.location_on_outlined, 'Webhopers Infotech'),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencySection() {
    return _buildCollapsibleSection(
      title: 'Currency',
      section: 'currency',
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.currency_rupee_outlined, color: Color(0xFF6B7280)),
                SizedBox(width: 8),
                Text('Rupee', style: TextStyle(color: Color(0xFF1F2937))),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Conversion Rate',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE5E7EB)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('1', style: TextStyle(color: Color(0xFF1F2937))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesPersonSection() {
    return _buildCollapsibleSection(
      title: 'Sales Person',
      section: 'salesPerson',
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
        child: Row(
          children: [
            Icon(Icons.person_outline, color: Color(0xFF6B7280)),
            SizedBox(width: 8),
            Text('Manager', style: TextStyle(color: Color(0xFF1F2937))),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadPerformaSection() {
    return _buildCollapsibleSection(
      title: 'Upload Performa',
      section: 'uploadPerforma',
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 15,right: 15,bottom: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFE5E7EB), style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              'No file chosen',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF3F4F6),
                foregroundColor: Color(0xFF374151),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Choose file'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Color(0xFF6B7280)),
          SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: color ?? Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }
}


//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:websuites/utils/components/buttons/common_button.dart';
// import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
// import 'package:websuites/data/models/responseModels/leads/list/lead_list.dart';
// import 'package:websuites/resources/strings/strings.dart';
// import 'package:websuites/utils/appColors/app_colors.dart';
// import 'package:websuites/utils/components/widgets/appBar/custom_appBar.dart';
// import 'package:websuites/utils/fontfamily/FontFamily.dart';
// import 'package:websuites/viewModels/leadScreens/createNewLead/product_category/product_category_controller.dart';
// import 'package:websuites/viewModels/leadScreens/lead_list/lead_detail_view/leadProductsViewModel/LeadProductsViewModel.dart';
// import 'package:websuites/viewModels/leadScreens/lead_list/lead_detail_view/projection/create/ProjetionViewModel.dart';
// import 'package:websuites/views/homeScreen/home_manager/HomeManagerScreen.dart';
//
// import '../CustomerDetailsScreen.dart';
//
// class CustomerCreateProjectionScreenController extends GetxController {
//   final RxList<Map<String, dynamic>> fieldSets = <Map<String, dynamic>>[].obs;
//   final RxBool autoValidate = false.obs;
//   final RxList<Map<String, String?>> errors = <Map<String, String?>>[].obs;
//   final ProjectionViewModel projectionViewModel = Get.put(ProjectionViewModel());
//
//   @override
//   void onInit() {
//     super.onInit();
//     resetForm();
//   }
//
//   @override
//   void onClose() {
//     for (var fieldSet in fieldSets) {
//       (fieldSet['category'] as TextEditingController?)?.dispose();
//       (fieldSet['product'] as TextEditingController?)?.dispose();
//       (fieldSet['amount'] as TextEditingController?)?.dispose();
//       (fieldSet['date'] as TextEditingController?)?.dispose();
//     }
//     super.onClose();
//   }
//
//   void addFieldSet() {
//     fieldSets.add({
//       'category': TextEditingController(),
//       'categoryId': '',
//       'product': TextEditingController(),
//       'productId': '',
//       'amount': TextEditingController(),
//       'date': TextEditingController(),
//     });
//     errors.add({
//       'category': null,
//       'product': null,
//       'amount': null,
//       'date': null,
//     });
//   }
//
//   void removeFieldSet(int index) {
//     fieldSets.removeAt(index);
//     errors.removeAt(index);
//     fieldSets.refresh();
//     errors.refresh();
//   }
//
//   void resetForm() {
//     for (var fieldSet in fieldSets) {
//       (fieldSet['category'] as TextEditingController?)?.dispose();
//       (fieldSet['product'] as TextEditingController?)?.dispose();
//       (fieldSet['amount'] as TextEditingController?)?.dispose();
//       (fieldSet['date'] as TextEditingController?)?.dispose();
//     }
//     fieldSets.clear();
//     errors.clear();
//     addFieldSet();
//     autoValidate.value = false;
//     fieldSets.refresh();
//     errors.refresh();
//   }
//
//   void navigateToCustomerDetails(String customerId) {
//     resetForm();
//     final homeController = Get.find<HomeManagerController>();
//     homeController.lastScreen.value = CustomerDetailsScreen(
//       customerId: customerId,
//       customerData: homeController.selectedCustomerDetail.value,
//       scaffoldKey: GlobalKey<ScaffoldState>(),
//     );
//     homeController.showOrderDetails.value = true;
//     homeController.update();
//     Get.back();
//   }
//
//   void createProjection(BuildContext context, String customerId, Item? orderItem) async {
//     // Validate fields before creating projection
//     bool isValid = true;
//     errors.clear();
//     for (var fieldSet in fieldSets) {
//       errors.add({
//         'category': fieldSet['category']!.text.isEmpty ? 'Category is required' : null,
//         'product': fieldSet['product']!.text.isEmpty ? 'Product is required' : null,
//         'amount': fieldSet['amount']!.text.isEmpty ? 'Amount is required' : null,
//         'date': fieldSet['date']!.text.isEmpty ? 'Date is required' : null,
//       });
//       if (errors.last.values.any((error) => error != null)) {
//         isValid = false;
//       }
//     }
//     autoValidate.value = true;
//     errors.refresh();
//
//     if (!isValid) {
//       return;
//     }
//
//     List<Map<String, dynamic>> projectionData = fieldSets.map((fieldSet) {
//       String formattedDate = fieldSet['date']!.text;
//       try {
//         if (fieldSet['date']!.text.isNotEmpty) {
//           final date = DateTime.parse(fieldSet['date']!.text);
//           formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date.toUtc());
//         }
//       } catch (e) {
//         print('Error parsing date: $e');
//       }
//
//       return {
//         'product_category': fieldSet['categoryId'],
//         'product': fieldSet['productId'],
//         'amount': double.tryParse(fieldSet['amount']!.text) ?? 0.0,
//         'projection_date': formattedDate,
//       };
//     }).toList();
//
//     // Use customerId as the id for the API request, assuming it matches the backend requirement
//     await projectionViewModel.projectionCreate(context, customerId, projectionData);
//
//     if (projectionViewModel.errorMessage.value.isEmpty) {
//       navigateToCustomerDetails(customerId);
//     }
//   }
// }
//
// class CustomerCreateProjectionScreen extends StatelessWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   final Item? orderItem;
//   final String customerId;
//
//   const CustomerCreateProjectionScreen({
//     Key? key,
//     required this.scaffoldKey,
//     this.orderItem,
//     required this.customerId,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final productCategoryController = Get.put(ProductCategoryController());
//     final leadProductsViewModel = Get.put(LeadProductsViewModel());
//     final controller = Get.put(CustomerCreateProjectionScreenController());
//     final homeController = Get.find<HomeManagerController>();
//     final bool isTablet = MediaQuery.of(context).size.width > 600;
//
//     productCategoryController.createLeadProductCategory(context);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       productCategoryController.createLeadProductCategory(context);
//       leadProductsViewModel.fetchLeadProducts(context);
//     });
//
//     return Container(
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomAppBar(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
//               child: Row(
//                 children: [
//                   if (!isTablet)
//                     IconButton(
//                       icon: const Icon(Icons.menu, color: Colors.black, size: 25),
//                       onPressed: () {
//                         scaffoldKey.currentState?.openDrawer();
//                       },
//                     ),
//                   if (isTablet) const SizedBox(width: 10),
//                   GestureDetector(
//                     onTap: () {
//                       controller.navigateToCustomerDetails(customerId);
//                     },
//                     child: Row(
//                       children: [
//                         const Icon(CupertinoIcons.back),
//                         const SizedBox(width: 8),
//                         Text(
//                           "Back",
//                           style: TextStyle(
//                             color: AllColors.blackColor,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: FontFamily.sfPro,
//                             fontSize: 17.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     "Add Projection",
//                     style: TextStyle(
//                       color: AllColors.blackColor,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: FontFamily.sfPro,
//                       fontSize: 17.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Obx(() => Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           Strings.productsCat,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black87,
//                             fontFamily: FontFamily.sfPro,
//                           ),
//                         ),
//                         const Spacer(),
//                         OutlinedButton.icon(
//                           onPressed: () => controller.addFieldSet(),
//                           icon: Icon(Icons.add, color: AllColors.greenJungle),
//                           label: Text(
//                             "Add",
//                             style: TextStyle(
//                               color: AllColors.greenJungle,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           style: OutlinedButton.styleFrom(
//                             side: BorderSide(color: AllColors.greenJungle),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 15,
//                               vertical: 10,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     ...controller.fieldSets.asMap().entries.map((entry) {
//                       final index = entry.key;
//                       final fieldSet = entry.value;
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (index > 0)
//                             Row(
//                               children: [
//                                 RichText(
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: Strings.productsCat,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.black87,
//                                           fontFamily: FontFamily.sfPro,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                         text: ' *',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 16,
//                                           color: Colors.red,
//                                           fontFamily: FontFamily.sfPro,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 CircleAvatar(
//                                   backgroundColor: AllColors.lightRed,
//                                   child: IconButton(
//                                     onPressed: () => controller.removeFieldSet(index),
//                                     icon: Icon(Icons.close, color: Colors.red),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           const SizedBox(height: 8),
//                           CreateNewLeadScreenCard(
//                             validator: null,
//                             hintText: "Select Category",
//                             controller: fieldSet['category']!,
//                             isEditable: true,
//                             categories: productCategoryController.leadProductCategories
//                                 .map((category) => category.name ?? '')
//                                 .toList(),
//                             onCategoryChanged: (selectedCategoryName) {
//                               final selectedCategory = productCategoryController.leadProductCategories.firstWhereOrNull(
//                                     (cat) => cat.name == selectedCategoryName,
//                               );
//                               if (selectedCategory != null) {
//                                 productCategoryController.updateSelectedCategories([selectedCategory.id ?? '']);
//                                 fieldSet['category']!.text = selectedCategory.name ?? '';
//                                 fieldSet['categoryId'] = selectedCategory.id ?? '';
//                                 leadProductsViewModel.selectedProduct.value = '';
//                                 fieldSet['product']!.clear();
//                                 fieldSet['productId'] = '';
//                                 fieldSet['amount']!.clear();
//                                 controller.fieldSets.refresh();
//                               }
//                             },
//                           ),
//                           if (controller.autoValidate.value && controller.errors[index]['category'] != null)
//                             Padding(
//                               padding: const EdgeInsets.only(top: 4.0, left: 12.0),
//                               child: Text(
//                                 controller.errors[index]['category']!,
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 12,
//                                   fontFamily: FontFamily.sfPro,
//                                 ),
//                               ),
//                             ),
//                           const SizedBox(height: 10),
//                           RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: Strings.product,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.black87,
//                                     fontFamily: FontFamily.sfPro,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: ' *',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 16,
//                                     color: Colors.red,
//                                     fontFamily: FontFamily.sfPro,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Obx(() {
//                             final selectedCategoryId = productCategoryController.selectedCategories.isNotEmpty
//                                 ? productCategoryController.selectedCategories.first
//                                 : '';
//                             final productNames = leadProductsViewModel.getProductNamesByCategoryId(selectedCategoryId);
//
//                             return CreateNewLeadScreenCard(
//                               hintText: "Select Product",
//                               controller: fieldSet['product']!,
//                               isEditable: true,
//                               categories: productNames,
//                               onCategoryChanged: (selectedProductName) {
//                                 leadProductsViewModel.selectedProduct.value = selectedProductName;
//                                 fieldSet['product']!.text = selectedProductName;
//
//                                 if (selectedProductName.isNotEmpty && leadProductsViewModel.products.isNotEmpty) {
//                                   final matchingProduct = leadProductsViewModel.products.first.items.firstWhereOrNull(
//                                         (item) => item.productCategory?.id == selectedCategoryId && item.name == selectedProductName,
//                                   );
//
//                                   if (matchingProduct != null) {
//                                     fieldSet['productId'] = matchingProduct.id ?? '';
//                                     fieldSet['amount']!.text = matchingProduct.mrp.toString();
//                                     controller.fieldSets.refresh();
//                                   }
//                                 }
//                               },
//                             );
//                           }),
//                           if (controller.autoValidate.value && controller.errors[index]['product'] != null)
//                             Padding(
//                               padding: const EdgeInsets.only(top: 4.0, left: 12.0),
//                               child: Text(
//                                 controller.errors[index]['product']!,
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 12,
//                                   fontFamily: FontFamily.sfPro,
//                                 ),
//                               ),
//                             ),
//                           const SizedBox(height: 10),
//                           RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: Strings.amount,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.black87,
//                                     fontFamily: FontFamily.sfPro,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: ' *',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 16,
//                                     color: Colors.red,
//                                     fontFamily: FontFamily.sfPro,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           CreateNewLeadScreenCard(
//                             controller: fieldSet['amount']!,
//                             hintText: "Enter Amount",
//                             validator: null,
//                             onChanged: (text) {
//                               if (controller.errors[index]['amount'] != null) {
//                                 controller.errors[index]['amount'] = null;
//                                 controller.errors.refresh();
//                               }
//                             },
//                           ),
//                           if (controller.autoValidate.value && controller.errors[index]['amount'] != null)
//                             Padding(
//                               padding: const EdgeInsets.only(top: 4.0, left: 12.0),
//                               child: Text(
//                                 controller.errors[index]['amount']!,
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 12,
//                                   fontFamily: FontFamily.sfPro,
//                                 ),
//                               ),
//                             ),
//                           const SizedBox(height: 10),
//                           RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: Strings.projectionDate,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.black87,
//                                     fontFamily: FontFamily.sfPro,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: ' *',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 16,
//                                     color: Colors.red,
//                                     fontFamily: FontFamily.sfPro,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           CreateNewLeadScreenCard(
//                             controller: fieldSet['date']!,
//                             hintText: "Select Date",
//                             prefixIcon: Icon(Icons.date_range_sharp, color: Colors.grey[300], size: 22),
//                             isDateField: true,
//                             validator: null,
//                             onChanged: (text) {
//                               if (controller.errors[index]['date'] != null) {
//                                 controller.errors[index]['date'] = null;
//                                 controller.errors.refresh();
//                               }
//                             },
//                           ),
//                           if (controller.autoValidate.value && controller.errors[index]['date'] != null)
//                             Padding(
//                               padding: const EdgeInsets.only(top: 4.0, left: 12.0),
//                               child: Text(
//                                 controller.errors[index]['date']!,
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 12,
//                                   fontFamily: FontFamily.sfPro,
//                                 ),
//                               ),
//                             ),
//                           const SizedBox(height: 20),
//                         ],
//                       );
//                     }).toList(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Flexible(
//                           child: CommonButton(
//                             height: 36,
//                             width: 90,
//                             borderRadius: 30,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                             title: 'Create',
//                             onPress: () => controller.createProjection(
//                               context,
//                               customerId,
//                               orderItem,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 20),
//                         Flexible(
//                           child: CommonButton(
//                             height: 36,
//                             color: Colors.grey[300],
//                             width: 90,
//                             borderRadius: 30,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                             title: 'Close',
//                             onPress: () => controller.navigateToCustomerDetails(customerId),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }