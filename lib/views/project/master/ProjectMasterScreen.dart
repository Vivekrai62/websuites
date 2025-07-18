import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import '../../../../viewModels/projects/master/list/ProjectMasterListViewModel.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class ProjectMasterScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const ProjectMasterScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  _ProjectMasterScreenState createState() => _ProjectMasterScreenState();
}

class _ProjectMasterScreenState extends State<ProjectMasterScreen> {
  final ProjectMasterListViewModel _viewModel = Get.put(ProjectMasterListViewModel(), permanent: true);
  bool isFloatingButtonClicked = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_viewModel.isDataInitialized.value) {
        _viewModel.projectMaster(context);
      }
    });
  }

  Future<void> _refreshProjectList() async {
    await _viewModel.projectMaster(context, forceRefresh: true); // Force refresh on pull
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      bottomNavigationBar:  CustomBottomNavBar(),
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
      body: Obx(() {
        // Show loading only when fetching data initially or during a refresh
        if (_viewModel.loading.value && _viewModel.projectsMaster.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            CustomAppBar(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
                child: Row(
                  children: [
                    if (!isTablet)
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black),
                        onPressed: () {
                          widget.scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                    if (isTablet) const SizedBox(width: 10),
                    Text(
                      'Setting',
                      style: TextStyle(
                        color: DarkMode.backgroundColor2(context),
                        fontWeight: FontWeight.w700,
                        fontSize: 17.5,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      width: 70,
                      height: 22,
                      borderRadius: 54,
                      child: InkWell(
                        onTap: () {
                          _showAddProductBottomSheet();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: AllColors.whiteColor, size: 18),
                            const SizedBox(width: 5),
                            const Text(
                              'Add',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: FontFamily.sfPro,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshProjectList,
                child:
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (_viewModel.projectsMaster.isEmpty && !_viewModel.loading.value) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: constraints.maxHeight,
                          child: const Center(
                            child: Text("No projects available"),
                          ),
                        ),
                      );
                    }

                    final double screenWidth = constraints.maxWidth;
                    int crossAxisCount = screenWidth < 600
                        ? 1
                        : screenWidth < 1200
                        ? 2
                        : 3;
                    final double itemWidth = (screenWidth - (crossAxisCount - 1) * 16) / crossAxisCount;
                    const double itemHeight = 92;
                    final double childAspectRatio = itemWidth / itemHeight;

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          if (isFloatingButtonClicked)
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                              child: TextField(
                                controller: searchController,
                                decoration: const InputDecoration(
                                  hintText: 'Search projects...',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.search),
                                ),
                                onChanged: (value) {
                                  // _viewModel.filterProjects(value); // Implement if needed
                                },
                              ),
                            ),
                          Stack(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: childAspectRatio,
                                ),
                                itemCount: _viewModel.projectsMaster.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == _viewModel.projectsMaster.length) {
                                    return const Center(
                                      child: Text("Pagination Placeholder"), // Replace with PaginationWidget if needed
                                    );
                                  }

                                  final projectMaster = _viewModel.projectsMaster[index];
                                  return GestureDetector(
                                    onTap: () {
                                      // Add navigation logic here if needed
                                    },
                                    child: ContainerUtils(
                                    
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded( // ⬅️ This constrains the Text widget properly
                                                child: Text(
                                                  projectMaster.name ?? 'N/A',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: FontFamily.sfPro,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8), // optional spacing
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                                decoration: BoxDecoration(
                                                  color: projectMaster.status == false
                                                      ? AllColors.lightRed
                                                      : AllColors.background_green,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: Text(
                                                  projectMaster.status == true ? 'Active' : 'Inactive',
                                                  style: TextStyle(
                                                    color: projectMaster.status == true
                                                        ? AllColors.text__green
                                                        : AllColors.darkRed,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: FontFamily.sfPro,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Image.asset(ImageStrings.date, height: 13, width: 13),
                                              const SizedBox(width: 8),
                                              Text(
                                                "11/12/2002", // Replace with actual date if available
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: FontFamily.sfPro,
                                                  fontSize: 12,
                                                  color: AllColors.mediumPurple,
                                                ),
                                              ),
                                              const Spacer(),
                                              Image.asset(ImageStrings.edit, height: 15, width: 15),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              if (_viewModel.loading.value)
                                const Positioned.fill(
                                  child: Center(child: CircularProgressIndicator()),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _showAddProductBottomSheet() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add New Tag',
                            style: TextStyle(
                              fontFamily: FontFamily.sfPro,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const Text('Name *'),
                      const CommonTextField(hintText: 'Enter Tag name'),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              width: 70,
                              height: 22,
                              borderRadius: 54,
                              child: const Text(
                                'SUBMIT',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.sfPro,
                                ),
                              ),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 20),
                            CustomButton(
                              backgroundColor: Colors.grey,
                              width: 70,
                              height: 22,
                              borderRadius: 54,
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.sfPro,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}