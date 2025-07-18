import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/components/widgets/appBar/custom_appBar.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/resources/strings/strings.dart';
import 'package:websuites/views/customerScreens/customerList/customerdetails/CustomerDetailsScreen.dart';
import 'package:websuites/views/homeScreen/home_manager/HomeManagerScreen.dart';
import 'package:websuites/data/models/responseModels/customers/list/customer_detail_view/list/customer_list_detail_view_list_response_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import '../../../../../resources/iconStrings/icon_strings.dart';
import '../../../../../resources/svg/svg_string.dart';
import '../../../../../resources/textStyles/responsive/test_responsive.dart';
import '../../../../../utils/button/CustomButton.dart';
import '../../../../../utils/dark_mode/dark_mode.dart';
import '../../../../../utils/responsive/responsive_utils.dart';

// class CustomerProformaCreateScreen extends StatefulWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey; // Remove the ? to make it non-nullable
//   final String? customerId;
//
//   const CustomerProformaCreateScreen({
//     super.key,
//     required this.scaffoldKey,
//     this.customerId,
//   });
//
//   @override
//   State<CustomerProformaCreateScreen> createState() => _CustomerProformaCreateScreenState();
// }

  // @override
  // State<CustomerProformaCreateScreen> createState() => _CustomerProformaCreateScreenState();


// class _CustomerProformaCreateScreenState extends State<CustomerProformaCreateScreen> {
//   final homeController = Get.find<HomeManagerController>();
//   final _formKey = GlobalKey<FormState>();
//   final _customerNameController = TextEditingController();
//   final _amountController = TextEditingController();
//   final _descriptionController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     // Pre-fill customer name if customerId is provided
//     _customerNameController.text = widget.customerId != null
//         ? 'Customer ID: ${widget.customerId}' // Placeholder; replace with actual customer name if fetched
//         : '';
//   }
//
//   @override
//   void dispose() {
//     _customerNameController.dispose();
//     _amountController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isTablet = MediaQuery.of(context).size.width > 600;
//
//     return Scaffold(
//       backgroundColor: AllColors.whiteColor,
//       body: Column(
//         children: [
//           CustomAppBar(
//             child: Row(
//               children: [
//                 // if (ResponsiveUtilsScreenSize.isMobile(context))
//                 GestureDetector(
//                   onTap: () => homeController.resetOrderDetails(),
//                   child: Row(
//                     children: [
//                       Icon(CupertinoIcons.back,
//                         color: DarkMode.backgroundColor2(context),),
//                       const SizedBox(width: 8),
//                       ResponsiveText.getAppBarTextSize(context, Strings.back),
//                     ],
//                   ),
//                 ),
//
//                 Spacer(),
//                 ResponsiveText.getAppBarTextSize(context, Strings.proCre),
//
//
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildTextField(
//                       controller: _customerNameController,
//                       label: 'Customer Name',
//                       validator: (value) =>
//                       value!.isEmpty ? 'Please enter customer name' : null,
//                       enabled: false, // Disable if pre-filled with customer data
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       controller: _amountController,
//                       label: 'Amount',
//                       keyboardType: TextInputType.number,
//                       validator: (value) =>
//                       value!.isEmpty ? 'Please enter amount' : null,
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       controller: _descriptionController,
//                       label: 'Description',
//                       maxLines: 4,
//                       validator: (value) =>
//                       value!.isEmpty ? 'Please enter description' : null,
//                     ),
//                     const SizedBox(height: 24),
//                     Center(
//                       child:
//                       ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             // Simulate saving proforma (replace with actual API call)
//                             Get.snackbar(
//                               'Success',
//                               'Proforma created successfully for Customer ID: ${widget.customerId}',
//                               snackPosition: SnackPosition.BOTTOM,
//                               backgroundColor: AllColors.greenJungle,
//                               colorText: Colors.white,
//                             );
//                             // Navigate back to CustomerDetailsScreen with cached data
//                             homeController.lastScreen.value = CustomerDetailsScreen(
//                               customerId: widget.customerId ?? '',
//                               customerData: homeController.selectedCustomerDetail.value, // Use cached data
//                               scaffoldKey: widget.scaffoldKey,
//                             );
//                             homeController.showOrderDetails.value = true;
//                             homeController.update();
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AllColors.mediumPurple,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 40, vertical: 12),
//                         ),
//                         child: Text(
//                           'Save Proforma',
//                           style: _textStyle(
//                               color: Colors.white, fontSize: 16),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     String? Function(String?)? validator,
//     TextInputType? keyboardType,
//     int maxLines = 1,
//     bool enabled = true,
//   }) {
//     return TextFormField(
//       controller: controller,
//       validator: validator,
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       enabled: enabled,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AllColors.mediumPurple),
//         ),
//       ),
//       style: _textStyle(fontSize: 14),
//     );
//   }
//
//   TextStyle _textStyle(
//       {Color? color, double? fontSize, FontWeight? fontWeight}) =>
//       TextStyle(
//         color: color ?? AllColors.blackColor,
//         fontSize: fontSize ?? 14,
//         fontWeight: fontWeight ?? FontWeight.w400,
//         fontFamily: FontFamily.sfPro,
//       );
// }



class CustomerProformaCreateScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey; // Remove the ? to make it non-nullable
  final String? customerId;

  const CustomerProformaCreateScreen({
    super.key,
    required this.scaffoldKey,
    this.customerId,
  });

  @override
  State<CustomerProformaCreateScreen> createState() => _CustomerProformaCreateScreenState();
}

@override
State<CustomerProformaCreateScreen> createState() => _CustomerProformaCreateScreenState();

class _CustomerProformaCreateScreenState extends State<CustomerProformaCreateScreen>

    with SingleTickerProviderStateMixin {
  final homeController = Get.find<HomeManagerController>();
  int _currentStep = 1;
  Customer? _selectedCustomer;
  List<int> _selectedServices = [];
  bool _showAddInstallment = false;
  String _searchTerm = '';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Customer> customers = [
    Customer(
      id: 1,
      name: 'Amit Industries',
      email: 'amitkumar@test.com',
      phone: '91 9876543210',
      contact: 'Sandeep Kumar',
      rating: 4.8,
      orders: 23,
    ),
    Customer(
      id: 2,
      name: 'TechCorp Solutions',
      email: 'fbvd@gmail.com',
      phone: '91 987654324',
      contact: 'Sandeep Kumar',
      rating: 4.9,
      orders: 45,
    ),
    Customer(
      id: 3,
      name: 'Digital Ventures',
      email: 'qwdwqedfr3grt456@gmail.com',
      phone: '91 0',
      contact: 'Rajesh Sharma',
      rating: 4.6,
      orders: 12,
    ),
    Customer(
      id: 4,
      name: 'StartupHub',
      email: 'info@startuphub.com',
      phone: '91 9988776655',
      contact: 'Priya Singh',
      rating: 4.7,
      orders: 8,
    ),
  ];

  final List<Service> services = [
    Service(
      id: 1,
      name: 'Landing Page Website',
      variants: 3,
      price: '₹15,000',
      popular: true,
      icon: '🌐',
    ),
    Service(
      id: 2,
      name: 'Premium E-commerce',
      variants: 2,
      price: '₹45,000',
      popular: false,
      icon: '🛒',
    ),
    Service(
      id: 3,
      name: 'WHSuites CRM 3.0',
      variants: 4,
      price: '₹25,000',
      popular: true,
      icon: '📊',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body:
        Column(
          children: [
            CustomAppBar(
              child: Row(
                children: [

                  GestureDetector(
                    onTap: () => homeController.resetOrderDetails(),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.back,
                          color: DarkMode.backgroundColor2(context),),
                        const SizedBox(width: 8),
                        ResponsiveText.getAppBarTextSize(context, Strings.back),
                      ],
                    ),
                  ),

                  Spacer(),
                  ResponsiveText.getAppBarTextSize(context, Strings.orderCreate),


                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration:  BoxDecoration(
                   color: DarkMode.backgroundColor(context)
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return
                          CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                                decoration: BoxDecoration(
                                    color: DarkMode.backgroundColor(context)

                                ),
                                child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ResponsiveText.getTitle(context, Strings.orderPro,fontSize:16,fontWeight: FontWeight.w600,color: DarkMode.building(context)),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: List.generate(5, (index) {
                                              final step = index + 1;
                                              return Row(
                                                children: [
                                                  Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      gradient: step == _currentStep
                                                          ?  LinearGradient(
                                                        colors: [
                                                          Colors.blue,
                                                         AllColors.mediumPurple,
                                                        ],
                                                      )
                                                          : step < _currentStep
                                                          ? const LinearGradient(
                                                        colors: [
                                                          Colors.green,
                                                          Colors.green,
                                                        ],
                                                      )
                                                          : null,
                                                      color: step < _currentStep ? null : Colors.grey[200],
                                                      boxShadow: step == _currentStep
                                                          ? [
                                                        BoxShadow(
                                                          color: Colors.blue.withOpacity(0.3),
                                                          blurRadius: 8,
                                                        ),
                                                      ]
                                                          : [],
                                                    ),
                                                    child: Center(
                                                      child: step < _currentStep
                                                          ? const Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                        size: 20,
                                                      )
                                                          : Text(
                                                        '$step',
                                                        style: TextStyle(
                                                          color: step == _currentStep
                                                              ? Colors.white
                                                              : Colors.grey,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  if (index < 4)
                                                    Container(
                                                      width: 40, // or any fixed value, or use MediaQuery if needed
                                                      height: 4,
                                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                                      color: step < _currentStep
                                                          ? Colors.green
                                                          : Colors.grey[200],
                                                    ),
                                                ],
                                              );
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.only(
                                  bottom: 80,
                                  left: 16,
                                  right: 16,
                                  top: 10
                              ),
                              sliver: SliverToBoxAdapter(
                                child: FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: _renderStep(constraints),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 8,
                          ),
                        ],
                        border: Border(top: BorderSide(color: Colors.grey[200]!)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: _currentStep == 1
                                ? null
                                : () => setState(() {
                              _currentStep = (_currentStep - 1).clamp(1, 5);
                              _animationController.reset();
                              _animationController.forward();
                            }),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.grey[700],
                              side: BorderSide(color: Colors.grey[300]!),
                            ),
                            icon: const Icon(Icons.chevron_left, size: 16),
                            label: const Text('Previous'),
                          ),
                          ElevatedButton.icon(
                            onPressed: _currentStep == 5
                                ? null
                                : () => setState(() {
                              _currentStep = (_currentStep + 1).clamp(1, 5);
                              _animationController.reset();
                              _animationController.forward();
                            }),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AllColors.mediumPurple,
                              foregroundColor: Colors.white,
                            ),
                            icon: _currentStep == 5
                                ? const Icon(Icons.check, size: 16)
                                : const Icon(Icons.chevron_right, size: 16),
                            label: Text(_currentStep == 5 ? 'Submit Order' : 'Next'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_showAddInstallment)
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey[200]!),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Add Payment Installment',
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Spacer(),
                                          IconButton(onPressed: (){
                                            Get.back();
                                          }, icon: Icon(Icons.close))
                                        ],
                                      ),

                                      Text(
                                        'Set up a new payment schedule',
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey[600],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Amount *',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey[50],
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Colors.grey[300]!,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Colors.blue,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: TextEditingController(text: '1200'),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Payment Date *',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey[50],
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Colors.grey[300]!,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Colors.blue,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        controller: TextEditingController(
                                          text: DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(DateTime.now()),
                                        ),
                                        readOnly: true,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Payment Method *',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      GridView.count(
                                        crossAxisCount: 2,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        childAspectRatio: 3.5,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey[50],
                                              foregroundColor: Colors.black,
                                              side: BorderSide(
                                                color: Colors.grey[300]!,
                                              ),
                                            ),
                                            child: const Text('💵 Cash'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue[50],
                                              foregroundColor: Colors.blue[600],
                                              side: const BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            child: const Text('📋 Cheque'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey[50],
                                              foregroundColor: Colors.black,
                                              side: BorderSide(
                                                color: Colors.grey[300]!,
                                              ),
                                            ),
                                            child: const Text('💳 Credit'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey[50],
                                              foregroundColor: Colors.black,
                                              side: BorderSide(
                                                color: Colors.grey[300]!,
                                              ),
                                            ),
                                            child: const Text('🌐 Online'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Transaction ID',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Enter Transaction ID',
                                          filled: true,
                                          fillColor: Colors.grey[50],
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Colors.grey[300]!,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Colors.blue,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Upload Document',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            style: BorderStyle.solid,
                                            color: Colors.grey[300]!,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.upload,
                                              size: 32,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Choose file or drag & drop',
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Payment Allocation *',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.orange[50],
                                          border: Border.all(
                                            color: Colors.orange[200]!,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Row(
                                          children: [
                                            Text('⚠️', style: TextStyle(fontSize: 16)),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                'Please adjust balance amount: ₹1,200',
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Landing Page Website (Due: ₹0)',
                                            ),
                                            SizedBox(
                                              width: 80,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  hintText: '₹0',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(
                                                      8,
                                                    ),
                                                  ),
                                                ),
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Premium (Due: ₹45,000)'),
                                            SizedBox(
                                              width: 80,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  hintText: '₹0',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(
                                                      8,
                                                    ),
                                                  ),
                                                ),
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(16),
                                    ),
                                    border: Border(
                                      top: BorderSide(color: Colors.grey[200]!),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () => setState(
                                                () => _showAddInstallment = false,
                                          ),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.grey[700],
                                            side: BorderSide(color: Colors.grey[300]!),
                                          ),
                                          child: const Text('Cancel'),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () => setState(
                                                () => _showAddInstallment = false,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AllColors.mediumPurple,
                                            foregroundColor: Colors.white,
                                          ),
                                          child: const Text('Add Installment'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
  }

  Widget _renderStep(BoxConstraints constraints) {
    switch (_currentStep) {
      case 1:
        final filteredCustomers = customers
            .where(
              (customer) =>
          customer.name.toLowerCase().contains(
            _searchTerm.toLowerCase(),
          ) ||
              customer.contact.toLowerCase().contains(
                _searchTerm.toLowerCase(),
              ),
        )
            .toList();
        return Column(
          children: [

            // foreground:
            // Paint()
            //   ..shader = const LinearGradient(
            //     colors: [Colors.blue, Colors.purple],
            //   ).createShader(const Rect.fromLTWH(0, 0, 200, 70
            //   )
            //   ),
            ResponsiveText.getTitle(context, Strings.selectCustomer,fontSize:20,fontWeight: FontWeight.w600),
           

            const SizedBox(height: 8),
            Text(
              'Choose your preferred customer',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => setState(() => _searchTerm = value),
              decoration: InputDecoration(
                hintText: 'Search companies...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredCustomers.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final customer = filteredCustomers[index];
                return GestureDetector(
                  onTap: () => setState(() => _selectedCustomer = customer),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedCustomer?.id == customer.id
                            ? Colors.blue
                            : Colors.grey[200]!,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      gradient: _selectedCustomer?.id == customer.id
                          ? const LinearGradient(
                        colors: [Color(0xFFE6F0FF), Color(0xFFF3E8FF)],
                      )
                          : null,
                      boxShadow: _selectedCustomer?.id == customer.id
                          ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8,
                        ),
                      ]
                          : [],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              customer.name,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      customer.rating.toString(),
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${customer.orders} orders',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.email,
                              size: 16,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 8),
                            Text(customer.email, style: GoogleFonts.poppins()),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 16,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            Text(customer.phone, style: GoogleFonts.poppins()),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 16,
                              color: Colors.purple,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              customer.contact,
                              style: GoogleFonts.poppins(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      case 2:
        return Column(
          children: [

            ResponsiveText.getTitle(context, 'Select Services',fontSize:20,fontWeight: FontWeight.w600),
            // Text(
            //   'Select Services',
            //   style: GoogleFonts.poppins(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     foreground: Paint()
            //       ..shader = const LinearGradient(
            //         colors: [Colors.blue, Colors.purple],
            //       ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
            //   ),
            // ),
            const SizedBox(height: 8),
            Text(
              'Choose your required services',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              items: [
                'Pharmahopers',
                'TechSolutions',
                'DigitalCorp',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) {},
              value: 'Pharmahopers',
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search services...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: services.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final service = services[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedServices.contains(service.id)
                          ? Colors.blue
                          : Colors.grey[200]!,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    gradient: _selectedServices.contains(service.id)
                        ? const LinearGradient(
                      colors: [Color(0xFFE6F0FF), Color(0xFFF3E8FF)],
                    )
                        : null,
                    boxShadow: _selectedServices.contains(service.id)
                        ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                      ),
                    ]
                        : [],
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _selectedServices.contains(service.id),
                        onChanged: (value) => setState(
                              () => _selectedServices.contains(service.id)
                              ? _selectedServices.remove(service.id)
                              : _selectedServices.add(service.id),
                        ),
                        activeColor: Colors.blue,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              service.icon,
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      service.name,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (service.popular)
                                      Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.orange,
                                              Colors.pink,
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          'Popular',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  '${service.variants} variants • Starting ${service.price}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // if (_selectedServices.contains(service.id))
                      //   Container(
                      //     padding: const EdgeInsets.all(4),
                      //     decoration: const BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: Colors.green,
                      //     ),
                      //     child: const Icon(
                      //       Icons.check,
                      //       color: Colors.white,
                      //       size: 16,
                      //     ),
                      //   ),
                    ],
                  ),
                );
              },
            ),
            if (_selectedServices.isNotEmpty) const SizedBox(height: 16),
            if (_selectedServices.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF5F7FA), Color(0xFFE6F0FF)],
                  ),
                  border: Border.all(color: Colors.blue[200]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected Services (${_selectedServices.length})',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _selectedServices.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final service = services.firstWhere(
                              (s) => s.id == _selectedServices[index],
                        );
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[200]!),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    service.icon,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service.name,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '${service.variants} variants available',
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () => setState(
                                      () => _selectedServices.remove(service.id),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        );
      case 3:
        return Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
              ResponsiveText.getTitle(context, Strings.confSer,fontSize:20,fontWeight: FontWeight.w600),
              const SizedBox(height: 8),
              Text(
                'Customize your service packages',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE6F0FF), Color(0xFFF3E8FF)],
                  ),
                  border: Border.all(color: Colors.blue[200]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('🌐', style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 8),
                        Text(
                          'Configuring: Landing Page Website',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[200]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Checkbox(value: false, onChanged: (value) {}),
                          Text(
                            'Make this item free',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[200]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Checkbox(value: false, onChanged: (value) {}),
                          Text(
                            'Include GST',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '18%',
                              style: GoogleFonts.poppins(
                                color: Colors.green[600],
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child:
                        CommonTextField(hintText: 'Start Date ',isDateField: true,)
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child:
                          CommonTextField(hintText: ' Date ',isDateField: true,)
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue[200]!),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Active',
                                      style: GoogleFonts.poppins(
                                        color: Colors.green[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.star_border,
                                    color: Colors.blue,
                                    size: 16,
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Edit',
                                  style: GoogleFonts.poppins(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Basic Package',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..shader =
                                 LinearGradient(
                                  colors: [Colors.blue,
                                  AllColors.mediumPurple
                                  ],
                                ).createShader(
                                  const Rect.fromLTWH(0, 0, 200, 70),
                                ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₹15,000.00 / 1 month',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..shader =
                                 LinearGradient(
                                  colors: [Colors.blue,
                                AllColors.mediumPurple
                                  ],
                                ).createShader(
                                  const Rect.fromLTWH(0, 0, 200, 70),
                                ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: constraints.maxWidth / 200,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Duration',
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      '1 Month',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Delivery Cycle',
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      '1 Month',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Base Cost',
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      '₹10,000.00',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price Multiplier',
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      'None',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.shield,
                                color: Colors.blue,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Features Included',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Pages: 10',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case 4:
        return Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
              ResponsiveText.getTitle(context, Strings.reviewOrders,fontSize:20,fontWeight: FontWeight.w600),
              const SizedBox(height: 8),
              Text(
                'Confirm all details before proceeding',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE6F0FF), Color(0xFFF3E8FF)],
                  ),
                  border: Border.all(color: Colors.blue[200]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.blue, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Customer Information',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person, color: Colors.grey, size: 16),
                          const SizedBox(width: 12),
                          Text(
                            'Sandeep Kumar',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.email, color: Colors.grey, size: 16),
                          const SizedBox(width: 12),
                          Text(
                            'amitkumar@test.com',
                            style: GoogleFonts.poppins(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.business,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 12),
                          Text('Amit Industries', style: GoogleFonts.poppins()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.grey, size: 16),
                          const SizedBox(width: 12),
                          Text('+91 9876543210', style: GoogleFonts.poppins()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF5F7FA), Color(0xFFE6F0FF)],
                  ),
                  border: Border.all(color: Colors.blue[200]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Order Summary',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Services:',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '2 selected',
                            style: GoogleFonts.poppins(
                              color: Colors.blue[800],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Date:',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        Text('09-07-2025', style: GoogleFonts.poppins()),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sales Person:',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        // DropdownButton<String>(
                        // value: 'Select Person...',
                        // items: ['Select Person...', 'John Doe', 'Jane Smith'].map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.poppins())).toList(),
                        // onChanged: (value) {},
                        // underline: const SizedBox(),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient:  LinearGradient(
                              colors: [Colors.blue,   AllColors.mediumPurple],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Landing Page Website',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.green, Colors.teal],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Premium Package',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
                  ),
                  border: Border.all(color: Colors.green[200]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.bolt, color: Colors.green, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Payment Summary',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹45,000.00',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [Colors.green, Colors.teal],
                          ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Details',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE6F0FF), Color(0xFFF3E8FF)],
                        ),
                        border: Border.all(color: Colors.blue[200]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                '🌐',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Landing Page Website',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,

                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Basic - ₹15,000.00 + GST ₹2,700.00',
                              style: GoogleFonts.poppins(
                                color: Colors.blue[600],
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: constraints.maxWidth / 200,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price:',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '₹15,000.00',
                                    style: GoogleFonts.poppins(),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Duration:',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text('1 month', style: GoogleFonts.poppins()),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Delivery:',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text('1 month', style: GoogleFonts.poppins()),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status:',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text('Active', style: GoogleFonts.poppins()),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
                        ),
                        border: Border.all(color: Colors.green[200]!),
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text('🛒', style: TextStyle(fontSize: 20)),
                              const SizedBox(width: 8),
                              Text(
                                'Premium Package',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Premium 3M - ₹45,000.00',
                              style: GoogleFonts.poppins(
                                color: Colors.green[600],
                                fontSize: 12,
                              ),
                            ),
                          ),

                        ],
                      ),

                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case 5:
        return Column(
          children: [
            Text(
              'Payment Details',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [Colors.blue, Colors.green],
                  ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Configure payment terms and submit order',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE6F0FF), Color(0xFFF3E8FF)],
                ),
                border: Border.all(color: Colors.blue[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.bolt, color: Colors.blue, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Payment Summary',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[900],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order Total', style: GoogleFonts.poppins()),
                      Text(
                        '₹45,000.00',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Paid', style: GoogleFonts.poppins()),
                      Text(
                        '₹0.00',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.green[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Remaining', style: GoogleFonts.poppins()),
                      Text(
                        '₹45,000.00',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.red[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Payment Status', style: GoogleFonts.poppins()),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Unpaid',
                          style: GoogleFonts.poppins(
                            color: Colors.red[600],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      border: Border.all(color: Colors.orange[200]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Text('⚠️', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'This order has a remaining balance of ₹45,000.00',
                            style: GoogleFonts.poppins(
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF5F7FA), Color(0xFFE6F0FF)],
                ),
                border: Border.all(color: Colors.blue[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Payment Installments',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[900],
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    icon: const Icon(Icons.add, size: 16),
                    label: Text(
                      'Add Installment',
                      style: GoogleFonts.poppins(),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      backgroundColor: Colors.blue[50],
                    ),
                    onPressed: () =>
                        setState(() => _showAddInstallment = true),
                  ),
                  Text(
                    'Set up payment schedules for this order',
                    style: GoogleFonts.poppins(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}


class Customer {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String contact;
  final double rating;
  final int orders;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.contact,
    required this.rating,
    required this.orders,
  });
}

class Service {
  final int id;
  final String name;
  final int variants;
  final String price;
  final bool popular;
  final String icon;

  Service({
    required this.id,
    required this.name,
    required this.variants,
    required this.price,
    required this.popular,
    required this.icon,
  });
}