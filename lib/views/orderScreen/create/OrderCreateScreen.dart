import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import 'package:websuites/views/leadScreens/leadList/widgets/manat.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datafilter/SeletDateFilter.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/customerScreens/proformas/CustomerProformaListViewModel.dart';
import '../../../viewModels/leadScreens/createNewLead/constant_controller/constant_controller.dart';
import '../../../viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
import '../../../viewModels/leadScreens/lead_list/lead_assign/lead_assign.dart';
import '../../homeScreen/home_manager/HomeManagerScreen.dart';
import '../../leadScreens/leadList/leadlist_screen.dart';

class FilterStateController extends GetxController {
  RxMap<String, RxList<FilterOptionItem>> selectedFilterItems =
      <String, RxList<FilterOptionItem>>{}.obs;

  void setSelectedItems(String filterId, List<FilterOptionItem> items) {
    selectedFilterItems[filterId] = RxList<FilterOptionItem>.from(items);
  }

  RxList<FilterOptionItem> getSelectedItems(String filterId) {
    return selectedFilterItems[filterId] ?? RxList<FilterOptionItem>();
  }

  void clearSelections() {
    selectedFilterItems.clear();
  }
}

final FilterStateController filterStateController =
    Get.put(FilterStateController());

class OrderCreateScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const OrderCreateScreen({
    super.key,
    required this.scaffoldKey,
  });

  @override
  _OrderCreateScreenState createState() => _OrderCreateScreenState();
}

class _OrderCreateScreenState extends State<OrderCreateScreen> {
  final CustomerProformaListViewModel _viewModel =
      Get.put(CustomerProformaListViewModel());
  final TextEditingController searchController = TextEditingController();
  bool isFloatingButtonClicked = false;

  final ListLeadAssignViewModel searchAssigned =
      Get.put(ListLeadAssignViewModel());
  final ConstantValueViewModel staticText = Get.put(ConstantValueViewModel());
  final DivisionsViewModel divisionList = Get.put(DivisionsViewModel());
  final HomeManagerController homeController =
      Get.find<HomeManagerController>();

  Future<void> _refreshLeadList() async {
    await _viewModel.fetchCustomerProformas(forceRefresh: true);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchAssigned.leadListLeadAssign(context);
      staticText.fetchConstantList(context);
      divisionList.fetchDivisions();
      _viewModel.fetchCustomerProformas(); // Initial fetch
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          setState(() {
            isFloatingButtonClicked =
                !isFloatingButtonClicked; // Toggle the state
          });
        },
        imageIcon: IconStrings.navSearch3,
        backgroundColor: AllColors.mediumPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: DarkMode.backgroundColor(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            child:   Row(
              children: [
                if (!isTablet)
                  IconButton(
                    icon:  Icon(Icons.menu, color: DarkMode.backgroundColor2(context)),
                    onPressed: () {
                      if (widget.scaffoldKey.currentState != null) {
                        if (!widget.scaffoldKey.currentState!.isDrawerOpen) {
                          widget.scaffoldKey.currentState!.openDrawer();
                        }
                      } else {
                        debugPrint("Scaffold key has no current state");
                      }
                    },
                  ),
                if (isTablet) const SizedBox(width: 10),
                Text(
                  'Order Create',
                  style: TextStyle(
                    color: DarkMode.backgroundColor2(context),
                    fontWeight: FontWeight.w700,
                    fontFamily: FontFamily.sfPro,
                    fontSize: 18.5,
                  ),
                ),
                const Spacer(),
                ContainerUtils(
                  width: 95,
                  height: 25,
                  paddingLeft: 0,
                  paddingRight: 0,
                  paddingTop: 0,
                  paddingBottom: 0,

                  borderRadius: BorderRadius.circular(24),
                  backgroundColor: AllColors.mediumPurple,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Create",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: FontFamily.sfPro,
                      fontWeight: FontWeight.w600,
                      color: AllColors.blackColor),
                ),
              ],
            ),
          )),
          CustomBottomNavBar(),
        ],
      ),
    );
  }
}
