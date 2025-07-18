import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';import '../../../../data/models/responseModels/master/departments/master_departments_response_model.dart';
import '../../../data/models/requestModels/userlist/department/add/UserDepartmentAddRequestModel.dart';
import '../../../data/models/requestModels/userlist/department/update/UserDepartmentUpdateRequestModel.dart';
import '../../../data/models/responseModels/userList/add/UserDepartmentAddResponsetModel.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../viewModels/master/departments/master_departments_viewModel.dart';
import '../../../viewModels/saveToken/save_token.dart';
import '../../../viewModels/userlistViewModel/department/UserDepartmentViewModel.dart';
import '../../../viewModels/userlistViewModel/department/add/UserAddDepartmentViewModel.dart';
import '../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class UsersDepartmentsScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const UsersDepartmentsScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<UsersDepartmentsScreen> createState() => _UsersDepartmentsScreenState();
}

class _UsersDepartmentsScreenState extends State<UsersDepartmentsScreen> {
  final MasterDepartmentsViewModel _masterViewModel =
      Get.put(MasterDepartmentsViewModel());

  final UserDepartmentViewModel _userDepartmentViewModel = Get.put(UserDepartmentViewModel()); // Use UserDepartmentViewModel

  final UserAddDepartmentViewModel _userAddDepartmentViewModel =
      Get.put(UserAddDepartmentViewModel()); // Use UserDepartmentViewModel

  SaveUserData userPreference = SaveUserData();

  String? userName = '';
  String? userEmail = '';

  Future<void> _refreshProjectList() async {
    await _masterViewModel.masterDepartments(context, forceRefresh: true);
  }

  @override
  void initState() {
    super.initState();

    _masterViewModel.masterDepartments(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor:              DarkMode.backgroundColor(context),
      // drawer: CustomDrawer(
      //   userName: '$userName',
      //   phoneNumber: '$userEmail',
      //   version: '1.0.12',
      // ),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Row(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'Departments',
      //         style: TextStyle(
      //             fontWeight: FontWeight.w700,
      //             fontSize: 20,
      //             fontFamily: FontFamily.sfPro),
      //       ),
      //       const Spacer(),
      //       Icon(Icons.search, color: AllColors.lightGrey),
      //       const SizedBox(width: 15),
      //       CustomButton(
      //         width: 70,
      //         height: 22,
      //         borderRadius: 54,
      //         onPressed: () {
      //
      //           UserDepartmentAddResponseModel addDepartment = UserDepartmentAddResponseModel(
      //             id: null,
      //             name: '',
      //             description: '',
      //             isDefault: true,
      //             createdAt: null,
      //             updatedAt: null,
      //           );
      //
      //           // Pass the correct model to the dialog
      //           _showDialog2(addDepartment); // Open the dialog to add/edit a department
      //         },
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Icon(Icons.add, color: AllColors.whiteColor, size: 18),
      //             const SizedBox(width: 5),
      //             const Text(
      //               'Add',
      //               style: TextStyle(
      //                 fontSize: 12,
      //                 fontWeight: FontWeight.w400,
      //                 fontFamily: FontFamily.sfPro,
      //               ),
      //             ),
      //           ],
      //         ),
      //       )
      //
      //
      //     ],
      //   ),
      // ),
      body: Obx(() {
        // Show loading indicator while fetching data
        if (_masterViewModel.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if departments customer_list is empty
        if (_masterViewModel.departments.isEmpty) {
          return const Center(child: Text('No departments found'));
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
                      onPressed: () {
                        UserDepartmentAddResponseModel addDepartment =
                            UserDepartmentAddResponseModel(
                          id: null,
                          name: '',
                          description: '',
                          isDefault: true,
                          createdAt: null,
                          updatedAt: null,
                        );

                        // Pass the correct model to the dialog
                        _showDialog2(
                            addDepartment); // Open the dialog to add/edit a department
                      },
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
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshProjectList,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (_masterViewModel.departments.isEmpty &&
                        !_masterViewModel.loading.value) {
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
                    final double itemWidth =
                        (screenWidth - (crossAxisCount - 1) * 16) /
                            crossAxisCount;
                    const double itemHeight = 100;
                    final double childAspectRatio = itemWidth / itemHeight;

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          // if (isFloatingButtonClicked)
                          //   Padding(
                          //     padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                          //     child: TextField(
                          //       controller: searchController,
                          //       decoration: const InputDecoration(
                          //         hintText: 'Search projects...',
                          //         border: OutlineInputBorder(),
                          //         prefixIcon: Icon(Icons.search),
                          //       ),
                          //       onChanged: (value) {
                          //         // _viewModel.filterProjects(value); // Implement if needed
                          //       },
                          //     ),
                          //   ),
                          Stack(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: childAspectRatio,
                                ),
                                itemCount:
                                    _masterViewModel.departments.length + 1,
                                itemBuilder: (context, index) {
                                  if (index ==
                                      _masterViewModel.departments.length) {
                                    return const Center(
                                      child: Text(
                                          ""), // Replace with PaginationWidget if needed
                                    );
                                  }

                                  final department =
                                      _masterViewModel.departments[index];
                                  return GestureDetector(
                                    onTap: () {},
                                    child: ContainerUtils(
                                      paddingBottom: 0,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                department.name ?? 'N/A',
                                                style: const TextStyle(
                                                    fontSize: 17.5,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const Spacer(),
                                              Expanded(
                                                child: Text(
                                                  department.description ??
                                                      'No description available',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          AllColors.figmaGrey,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily:
                                                          FontFamily.sfPro),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                  'assets/icons/date.png',
                                                  height: 13,
                                                  width: 13),
                                              const SizedBox(width: 10),
                                              Text(
                                                formatDateWithDay(
                                                    department.createdAt ??
                                                        'N/A'),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                        AllColors.mediumPurple,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                onPressed: () {
                                                  _showDialog(department);
                                                },
                                                icon: Image.asset(
                                                    'assets/icons/edit.png',
                                                    height: 16,
                                                    width: 16),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              if (_masterViewModel.loading.value)
                                const Positioned.fill(
                                  child: Center(
                                      child: CircularProgressIndicator()),
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

  void _showDialog(MasterDepartmentsResponseModel department) {
    final TextEditingController nameController =
        TextEditingController(text: department.name);
    final TextEditingController descriptionController =
        TextEditingController(text: department.description);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AllColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Edit Department',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CommonTextField(
                        hintText: 'Name',
                        controller: nameController,
                      ),
                      const SizedBox(height: 10),
                      CommonTextField(
                        hintText: 'Description',
                        controller: descriptionController,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        width: double.infinity,
                        height: 40,
                        borderRadius: 8,
                        onPressed: () async {
                          // Create the request model with updated values
                          UserDepartmentUpdateRequestModel updatedDepartment =
                              UserDepartmentUpdateRequestModel(
                            name: nameController.text,
                            description: descriptionController.text,
                          );

                          await _userDepartmentViewModel
                              .updateUserDepartmentApi(
                                  context, updatedDepartment, department.id);

                          // Close the dialog
                          Navigator.pop(context);
                        },
                        child: Text('Save',
                            style: TextStyle(color: AllColors.whiteColor)),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.black, size: 14),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDialog2(UserDepartmentAddResponseModel addDepartment) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AllColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Add Department',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CommonTextField(
                        hintText: 'Name',
                        controller: nameController,
                      ),
                      const SizedBox(height: 10),
                      CommonTextField(
                        hintText: 'Description',
                        controller: descriptionController,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        width: double.infinity,
                        height: 40,
                        borderRadius: 8,
                        onPressed: () async {
                          // Create the request model with entered values
                          UserDepartmentAddRequestModel newDepartment =
                              UserDepartmentAddRequestModel(
                            name: nameController.text,
                            description: descriptionController.text,
                          );

                          // Call the ViewModel to add the department
                          await _userAddDepartmentViewModel
                              .usersAddDepartmentApi(
                            context,
                            newDepartment,
                          );

                          // Close the dialog after creating the department
                          Navigator.pop(context);
                        },
                        child: Text('Save',
                            style: TextStyle(color: AllColors.whiteColor)),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.black, size: 14),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
