import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import '../../../resources/imageStrings/image_strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../viewModels/saveToken/save_token.dart';
import '../../../viewModels/tasks/master/task_master_list_view_model.dart';
import 'package:websuites/data/models/responseModels/projects/list/projects_list_response_model.dart'
    as projectModel;

class TasksMasterScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(projectModel.Item)? onOrderSelected;

  const TasksMasterScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<TasksMasterScreen> createState() => _TasksMasterScreenState();
}

class _TasksMasterScreenState extends State<TasksMasterScreen> {
  final TaskMasterListViewModel _viewModel = Get.put(TaskMasterListViewModel());
  final ScrollController _scrollController = ScrollController();
  final SaveUserData userPreference = SaveUserData();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.tasksMasterApi(
          context); // This will only fetch if data is not already present
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      _viewModel.loadNextPage(context);
    }
  }

  Future<void> refreshList() async {
    await _viewModel.refreshList(context); // This will force a refresh
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {},
        imageIcon: IconStrings.navSearch3,
        backgroundColor: AllColors.mediumPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      body: Obx(() => _viewModel.loading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                          'Task Master List',
                          style: TextStyle(
                            color: AllColors.blackColor,
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
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add,
                                  color: AllColors.whiteColor, size: 18),
                              const SizedBox(width: 5),
                              Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 12,
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
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: refreshList,
                    child: _viewModel.taskMaster.isEmpty
                        ? const Center(child: Text("No tasks available"))
                        : GridView.builder(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isTablet ? 2 : 1,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      (isTablet ? 260 : 95),
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: _viewModel.taskMaster.length,
                            itemBuilder: (context, index) {
                              final taskMaster = _viewModel.taskMaster[index];

                              return GestureDetector(
                                onTap: () {},
                                child: ContainerUtils(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              taskMaster.name ?? "No Name",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                fontFamily: FontFamily.sfPro,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,

                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: taskMaster.status == true
                                                  ? AllColors.background_green
                                                  : AllColors.lightRed,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: Text(
                                                taskMaster.status == true
                                                    ? 'Active'
                                                    : 'Inactive',
                                                style: TextStyle(
                                                  color: taskMaster.status ==
                                                          true
                                                      ? AllColors.text__green
                                                      : AllColors.darkRed,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(ImageStrings.date,
                                              height: 14, width: 14),
                                          Expanded(
                                            child: Text(
                                              '    ${taskMaster.createdAt != null ? dateFormat.format(taskMaster.createdAt!) : "N/A"}',
                                              style: TextStyle(
                                                color: AllColors.mediumPurple,
                                                fontFamily: FontFamily.sfPro,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Image.asset('assets/icons/edit.png',
                                              height: 15, width: 14),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            )),
    );
  }
}
