import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../viewModels/product/master/product_master_viewModel.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../utils/dark_mode/dark_mode.dart';
import '../../viewModels/projects/list/project_list_view_model.dart';
import '../../viewModels/saveToken/save_token.dart';
import 'details/ProjectDetailsScreen.dart';
import 'package:websuites/data/models/responseModels/projects/list/projects_list_response_model.dart'
    as projectModel;

class ProjectListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(projectModel.Item)? onOrderSelected; // Updated type

  const ProjectListScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  final ProjectListViewModel _viewModel = Get.put(ProjectListViewModel());
  final ScrollController _scrollController = ScrollController();
  SaveUserData userPreference = SaveUserData();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_viewModel.projectList.isEmpty) {
        _viewModel.fetchProjectList(context);
      }
    });

    // Add listener to the scroll controller
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      _viewModel.loadNextPage(context);
    }
  }

  Future<void> refreshList() async {
    await _viewModel
        .refreshList(context); // Call the refresh method from the ViewModel
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          // Add search or filter functionality here if needed
        },
        imageIcon: IconStrings.navSearch3,
        backgroundColor: AllColors.mediumPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: DarkMode.backgroundColor(context),
      body: Obx(() {
        if (_viewModel.isLoading.value) {
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
                      'Product Master List',
                      style: TextStyle(
                        color: DarkMode.backgroundColor2(context),
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 18.5,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      width: 70,
                      height: 22,
                      borderRadius: 54,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add,
                              color: AllColors.whiteColor, size: 18),
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
                      onPressed: () {
                        // Add product creation logic here
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: refreshList, // Call the refreshList method here
                child: _viewModel.projectList.isEmpty
                    ? const Center(child: Text("No products available"))
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          if (_viewModel.projectList.isEmpty) {
                            return SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                height: constraints.maxHeight,
                                child: const Center(
                                  child: Text("No products available"),
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
                          final double itemWidth =
                              (screenWidth - (crossAxisCount - 1) * 16) /
                                  crossAxisCount;
                          const double itemHeight = 205;
                          final double childAspectRatio =
                              itemWidth / itemHeight;

                          return GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: childAspectRatio,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: _viewModel.projectList.length,
                            itemBuilder: (context, index) {
                              final project = _viewModel.projectList[index];
                              final customer = project.customer;

                              return InkWell(
                                onTap: () {
                                  if (widget.onOrderSelected != null) {
                                    widget.onOrderSelected!(project);
                                  } else {
                                    // Create a new instance of ProjectDetailsController with the selected projectId
                                    Get.delete<
                                        ProjectDetailsController>(); // Remove any existing instance
                                    Get.put(ProjectDetailsController(
                                        project.id.toString()));
                                    Get.to(() => ProjectDetailsScreen(
                                          projectId: project.id.toString(),
                                          scaffoldKey: widget.scaffoldKey,
                                        ));
                                  }
                                },
                                child: ContainerUtils(

                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              project.projectName?.isNotEmpty ==
                                                      true
                                                  ? project.projectName!
                                                  : 'Unnamed Project',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {});
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 1.5),
                                                decoration: BoxDecoration(
                                                  color: AllColors.lightBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      project.status
                                                                  ?.isNotEmpty ==
                                                              true
                                                          ? project.status!
                                                          : 'Unknown',
                                                      style: TextStyle(
                                                        color:
                                                            AllColors.darkBlue,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${customer?.firstName ?? ''} ${customer?.lastName ?? ''}',
                                                style:  TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: FontFamily.sfPro,
                                                  fontWeight: FontWeight.w400,
                                                  color: DarkMode.backgroundColor2(context),
                                                ),
                                                maxLines:
                                                    1, // Limit to one line
                                                overflow: TextOverflow
                                                    .ellipsis, // Show ellipsis if text overflows
                                              ),
                                            ),
                                            // SizedBox(width: 0),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 1.5),
                                              decoration: BoxDecoration(
                                                color: AllColors.lightYellow,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Text(
                                                (project.tags.isNotEmpty ??
                                                        false)
                                                    ? project.tags
                                                        .map((tag) => tag.name)
                                                        .join(', ')
                                                    : 'Not Available',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.orange[800],
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              '${project.billingType}',
                                              overflow: TextOverflow.ellipsis,
                                              style:  TextStyle(
                                                  fontSize: 12,
                                                  color: DarkMode.backgroundColor2(context),
                                                  fontFamily: FontFamily.sfPro),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                 Text(
                                                  'START DATE',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: DarkMode.backgroundColor2(context),
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  project.startDate != null
                                                      ? DateFormat(
                                                              'MMM dd, yyyy')
                                                          .format(project
                                                              .startDate!)
                                                      : 'N/A',
                                                  style:  TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    color: DarkMode.backgroundColor2(context),),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                 Text(
                                                  'DEADLINE',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: DarkMode.backgroundColor2(context),
                                                      fontFamily:
                                                           FontFamily.sfPro,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  project.deadline != null
                                                      ? DateFormat(
                                                              'MMM dd, yyyy')
                                                          .format(
                                                              project.deadline!)
                                                      : 'N/A',
                                                  style:  TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    color: DarkMode.backgroundColor2(context),),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Divider(
                                          thickness: 0.4,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'MEMBERS - ',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              project.members.length
                                                      .toString() ??
                                                  'N/A',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey),
                                            ),
                                            const Spacer(),
                                            if (project.members.isNotEmpty) ...[
                                              const Divider(height: 30),
                                              Wrap(
                                                spacing: 0,
                                                children: project.members
                                                    .map((member) {
                                                  String firstLetter = member
                                                          .firstName
                                                          .toString()
                                                          .isNotEmpty
                                                      ? member.firstName
                                                          .toString()[0]
                                                          .toUpperCase()
                                                      : 'N'; // Default to 'N' if no first name is available

                                                  // Use modulo to ensure the color stays within the range of Colors.primaries
                                                  Color backgroundColor = Colors
                                                      .primaries[project.members
                                                          .indexOf(member) %
                                                      Colors.primaries.length];

                                                  return Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 3),
                                                    child: CircleAvatar(
                                                      radius: 12,
                                                      backgroundColor: member
                                                                  .profilePic ==
                                                              null
                                                          ? backgroundColor
                                                              .withOpacity(0.5)
                                                          : null,
                                                      backgroundImage: member
                                                                  .profilePic !=
                                                              null
                                                          ? NetworkImage(member
                                                              .profilePic
                                                              .toString())
                                                          : null,
                                                      child: member
                                                                  .profilePic ==
                                                              null
                                                          ? Text(
                                                              firstLetter,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12),
                                                            )
                                                          : null, // No text if profile_pic is present
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ]
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
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
}
