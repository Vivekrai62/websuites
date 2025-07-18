import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import 'package:websuites/views/leadScreens/leadList/widgets/manat.dart';
import '../../../data/repositories/repositories.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../resources/strings/strings.dart';
import '../../../resources/svg/svg_string.dart';
import '../../../resources/textStyles/responsive/test_responsive.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datafilter/SeletDateFilter.dart';
import '../../../utils/filter_button/filter_buttons.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../utils/responsive/responsive_utils.dart';
import '../../../viewModels/customerScreens/proformas/CustomerProformaListViewModel.dart';
import '../../../viewModels/customerScreens/proformas/view/customer_proforma_view_viewmodel.dart';
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

class CustomerProformaList extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomerProformaList({
    super.key,
    required this.scaffoldKey,
  });

  @override
  _CustomerProformaListState createState() => _CustomerProformaListState();
}

class _CustomerProformaListState extends State<CustomerProformaList> {
  final InvoiceViewModel _viewModel = Get.put(InvoiceViewModel(Repositories()));
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
      _viewModel.fetchCustomerProformas();
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
      bottomNavigationBar: const CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          setState(() {
            isFloatingButtonClicked = !isFloatingButtonClicked;
          });
        },
        imageIcon: IconStrings.navSearch3,
        backgroundColor: AllColors.mediumPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: DarkMode.backgroundColor(context),
      body: Column(
        children: [
          CustomAppBar(
            child: Row(
              children: [
                if (ResponsiveUtilsScreenSize.isMobile(context))
                  GestureDetector(
                    onTap: () {
                      widget.scaffoldKey.currentState?.openDrawer();
                    },
                    child: SvgIcon(
                      assetPath: IconStrings.drawer,
                      color: DarkMode.backgroundColor2(context),
                    ),
                  ),
                if (ResponsiveUtilsScreenSize.isMobile(context))
                  const SizedBox(width: 10),
                ResponsiveText.getAppBarTextSize(context, Strings.proformaList),
                const Spacer(),
                GestureDetector(
                  onTap: () => openProformasFilterBottomSheet(context),
                  child: FilterButton(
                    text: Strings.filter,
                    iconPath: 'assets/icons/FilterIcon.png',
                    iconColor: AllColors.mediumPurple,
                    borderColor: AllColors.filterTextColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (_viewModel.loading.value &&
                  _viewModel.customerProItems.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return RefreshIndicator(
                onRefresh: _refreshLeadList,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Column(
                      children: [
                        if (isFloatingButtonClicked)
                          CommonTextField(
                            hintText: 'Search proformas...',
                            onSearch: (value) {
                              _viewModel.searchProformas(value);
                            },
                            controller: searchController,
                          ),
                        ResponsiveMasonryGridView(
                          padding: EdgeInsets.all(0),
                          items: _viewModel.customerProItems,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, item, index) {
                            return GestureDetector(
                              onTap: () {
                                debugPrint('View proforma for ${item.id}');
                              },
                              child:
                              ContainerUtils(
                                paddingTop: 19,
                                paddingLeft: 14,
                                paddingRight: 14,
                                paddingBottom: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ResponsiveText.getTitleText(
                                            context,
                                            item.name ?? 'Unknown Name',
                                          ),
                                        ),
                                        Text(
                                          '#${item.performaNumber ?? 'N/A'}',
                                          style: TextStyle(
                                            color: AllColors.grey,
                                            fontFamily: FontFamily.sfPro,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    ResponsiveText.getSubTitle(
                                      context,
                                      item.email ?? 'No Email',
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        SvgIcon(
                                          assetPath: IconStrings.calender,
                                          size: 14.0,
                                          color: DarkMode.mobileColor(context),
                                        ),
                                        const SizedBox(width: 10),
                                        ResponsiveText.getDateTitle(
                                          context,
                                          '${formatDate(item.createdAt ?? 'Unknown Date')}',
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: AllColors.backFavRed,
                                          ),
                                          child:

                                          ResponsiveText.getSubTitle(
                                            context,
                                            item.createdBy?.firstName ?? 'N/A',
                                            color: AllColors.favRed,

                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const Divider(thickness: 0.4),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: AllColors.lighterPurple,
                                          ),
                                          child: Text(
                                            item.division?.name ?? 'Unknown',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: FontFamily.sfPro,
                                              letterSpacing: 0,
                                              color: AllColors.mediumPurple,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            if (item.id != null) {
                                              Get.to(() => InvoicePreviewScreen(
                                                    invoiceId: item.id!,
                                                    scaffoldKey: GlobalKey<
                                                        ScaffoldState>(),
                                                  ));
                                            } else {
                                              Get.snackbar('Error',
                                                  'Invalid proforma ID');
                                            }
                                          },
                                          child: SvgIcon(
                                              assetPath: IconStrings.eye),
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
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void openProformasFilterBottomSheet(BuildContext context) {
    final Map<String, Widget Function(BuildContext)> customBuilders = {};
    final constants = staticText.constantList.isNotEmpty
        ? staticText.constantList.first
        : null;
    FilterUtils.searchText.value = '';

    final TextEditingController createDateController = TextEditingController();

    final filterData = {
      'date_range': {
        'title': 'Create Date',
        'hintText': 'Select Date',
        'isSingleSelect': true,
        'widget': SelectDate(
          hintText: 'Select Date',
          filterIdentifier: 'date_range',
          controller: createDateController,
          onDateRangeSelected: (start, end) {
            if (start != null && end != null) {
              final formattedRange = {
                'from':
                    "${start.toIso8601String().substring(0, 10)} 00:00:00.000",
                'to': "${end.toIso8601String().substring(0, 10)} 23:59:59.999",
              };
              createDateController.text = jsonEncode(formattedRange);
            } else {
              createDateController.text = '';
            }
          },
        ),
      },
      'lead_assigned': {
        'title': 'Lead Assigned',
        'hintText': 'Select Assignee',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(
              label: constants?.withteam ?? 'With Team', id: 'withteam'),
          FilterOptionItem(
              label: constants?.individual ?? 'Individual', id: 'individual'),
        ]),
      },
      'created_by': {
        'title': 'Created By',
        'hintText': 'Search',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          searchAssigned.leadAssignList.map((lead) {
            return FilterOptionItem(
                label: lead.firstName ?? 'N/A', id: lead.id);
          }).toList(),
        ),
      },
      'division': {
        'title': 'Division',
        'hintText': 'Search Division',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          divisionList.divisionsList.map((division) {
            return FilterOptionItem(
                label: division.name ?? 'N/A', id: division.id);
          }).toList(),
        ),
      },
    };

    filterData.forEach((filterId, data) {
      final items = data['items'] as RxList<FilterOptionItem>?;
      if (items != null) {
        final previouslySelected =
            filterStateController.getSelectedItems(filterId);
        for (var item in items) {
          item.isSelected.value = previouslySelected.any((selected) =>
              selected.label == item.label && selected.id == item.id);
        }
      }
    });

    filterData.forEach((filterId, data) {
      customBuilders[filterId] = (context) {
        final widget = data['widget'] as Widget?;
        if (widget != null) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
              child: widget,
            ),
          );
        }

        final items = data['items'] as RxList<FilterOptionItem>? ??
            RxList<FilterOptionItem>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 9, bottom: 0, left: 10, right: 10),
              child: SizedBox(
                height: 43,
                child: TextField(
                  onChanged: (value) {
                    FilterUtils.searchText.value = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Search ${data['title']}',
                    prefixIcon: Icon(Icons.search,
                        color: AllColors.figmaGrey, size: 25),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide:
                          BorderSide(color: AllColors.mediumPurple, width: 0.6),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                final filteredItems = FilterUtils.getFilteredItems(items);
                return ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          top: item.isSelected.value ? 5 : 0,
                          bottom: item.isSelected.value ? 0 : 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: item.isSelected.value
                              ? AllColors.mediumPurple.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: Text(
                                  item.label,
                                  style: const TextStyle(
                                      fontSize: 14.5, color: Colors.black),
                                ),
                              ),
                              const Spacer(),
                              Obx(() => Transform.scale(
                                    scale: 0.8,
                                    child: Checkbox(
                                      value: item.isSelected.value,
                                      onChanged: (newValue) {
                                        FilterUtils.handleSelection(items, item,
                                            data['isSingleSelect'] as bool);
                                        if (data['isSingleSelect'] as bool &&
                                            newValue == true) {
                                          FilterUtils.searchText.value = '';
                                        }
                                      },
                                      activeColor: AllColors.mediumPurple,
                                      checkColor: Colors.white,
                                      side: BorderSide(
                                          color: AllColors.mediumPurple),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      };
    });

    showManatFilter(
      context,
      FilterConfig(
        title: "My Filters",
        primaryColor: AllColors.mediumPurple,
        filterOptionss: [
          FilterOption(
            id: 'date_range',
            label: 'Date Range',
            hintText: 'Select Date',
            icon: Icons.calendar_today,
            isMultiSelect: false,
          ),
          FilterOption(
            id: 'lead_assigned',
            label: 'Lead Assigned',
            hintText: 'Select Assignee',
            icon: Icons.people,
            isMultiSelect: false,
          ),
          FilterOption(
            id: 'created_by',
            label: 'Created By',
            hintText: 'Search',
            icon: Icons.person,
            isMultiSelect: true,
          ),
          FilterOption(
            id: 'division',
            label: 'Division',
            hintText: 'Division',
            icon: Icons.business,
            isMultiSelect: true,
          ),
        ],
        customBuilders: customBuilders,
        onFilterApplied: (filterId, selectedItems) {
          Map<String, dynamic> selectedFilters = {};

          filterData.forEach((filterId, data) {
            final items = data['items'] as RxList<FilterOptionItem>? ??
                RxList<FilterOptionItem>();
            final selected =
                items.where((item) => item.isSelected.value).toList();
            if (selected.isNotEmpty) {
              filterStateController.setSelectedItems(filterId, selected);
              final isSingleSelect = data['isSingleSelect'] as bool? ?? true;
              if (isSingleSelect) {
                final selectedItem = selected.first;
                switch (filterId) {
                  case 'division':
                    selectedFilters['division'] = selectedItem.id;
                    break;
                  case 'created_by':
                    selectedFilters['created_by'] = selectedItem.id;
                    break;
                  case 'lead_assigned':
                    selectedFilters['lead_assigned'] = selectedItem.id;
                    break;
                  default:
                    selectedFilters[filterId] =
                        selectedItem.id ?? selectedItem.label;
                }
              } else {
                selectedFilters[filterId] =
                    selected.map((item) => item.id ?? item.label).toList();
              }
            }
          });

          try {
            if (createDateController.text.isNotEmpty) {
              selectedFilters['range'] = jsonDecode(createDateController.text);
            }
          } catch (e) {
            print('Error parsing date range filters: $e');
          }

          print('Selected Filters: $selectedFilters');
          Get.find<CustomerProformaListViewModel>()
              .applyFilters(selectedFilters);
        },
      ),
    );
  }
}

class InvoicePreviewScreen extends StatelessWidget {
  final String invoiceId;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const InvoicePreviewScreen(
      {super.key, required this.invoiceId, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<InvoiceViewModel>();
    final homeController = Get.find<HomeManagerController>();

    // Auto-fetch PDF on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchInvoicePdf(invoiceId);
    });

    return Scaffold(
      backgroundColor: DarkMode.backgroundColor(context),

      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: const Text('Invoice Preview'),
      //   actions: [
      //     Obx(() => viewModel.pdfFile.value != null
      //         ? IconButton(
      //             icon: const Icon(Icons.download),
      //             onPressed: () => viewModel.downloadPdf(),
      //           )
      //         : const SizedBox.shrink()),
      //   ],
      // ),

      body: Obx(() {
        if (viewModel.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (viewModel.error.value.isNotEmpty) {
          return Center(child: Text('Error: ${viewModel.error.value}'));
        }

        return Column(
          children: [
            CustomAppBar(
              child: Row(
                children: [
                  GestureDetector(
                    onTap:(){
                      Get.back();

        },
                    child: Icon(
                      CupertinoIcons.back,
                      color: DarkMode.backgroundColor2(context),
                    ),
                  ),
                  ResponsiveText.getAppBarTextSize(context, Strings.inVoice),
                  Spacer(),


                  // ),

                  Icon(
                    Icons.download,
                    color: DarkMode.backgroundColor2(context),
                    size: 23,
                  ),

                  SizedBox(width: 15,),
                  CustomButton(

                    width: ResponsiveUtilsScreenSize.isMobile(context) ? 70 : 85,
                    height: ResponsiveUtilsScreenSize.isMobile(context) ? 28 : 28,
                    borderRadius: 54,
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share,
                          color: AllColors.whiteColor,
                          size: ResponsiveUtilsScreenSize.isMobile(context) ? 16 : 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          Strings.share,
                          style: TextStyle(
                            fontSize: ResponsiveUtilsScreenSize.isMobile(context) ? 11 : 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.sfPro,
                            color: AllColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: viewModel.pdfFile.value != null
                  ? Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5),
                    child: PDFView(
                        backgroundColor: DarkMode.backgroundColor(context),
                        filePath: viewModel.pdfFile.value!.path),
                  )
                  : const Center(child: Text('No PDF available')),
            ),
          ],
        );
      }),
    );
  }
}
