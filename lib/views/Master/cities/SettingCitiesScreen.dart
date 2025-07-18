import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import '../../../../data/models/responseModels/master/proposals/master_proposals_resposne_model.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/container_Utils/ContainerUtils.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../viewModels/master/citiesStatesAndCountry/cities/master_cities_viewModel.dart';
import '../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class SettingCitiesScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const SettingCitiesScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<SettingCitiesScreen> createState() => _SettingCitiesScreenState();
}

class _SettingCitiesScreenState extends State<SettingCitiesScreen> {
  final MasterCitiesViewModel _viewModel = Get.put(MasterCitiesViewModel());

  @override
  void initState() {
    super.initState();
    _viewModel.masterCities(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: DarkMode.backgroundColor(context),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text('Cities',
      //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
      //   ),
      // ),
      body: Column(
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
                    'Cities',
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
                      // _showDialog(context);
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
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (_viewModel.loading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final citiesData = _viewModel.citiesData.value;
              if (citiesData?.items == null || citiesData!.items!.isEmpty) {
                return const Center(child: Text('No cities found'));
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  if (citiesData.items == null || citiesData.items!.isEmpty) {
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
                  const double itemHeight = 90;
                  final double childAspectRatio = itemWidth / itemHeight;

                  // Rest of the code remains the same
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
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
                              itemCount: citiesData.items!.length,
                              itemBuilder: (context, index) {
                                final city = citiesData.items![index];

                                return GestureDetector(
                                  onTap: () {},
                                  child: ContainerUtils(
                                    paddingBottom: 0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                city.name ?? 'Unknown City',
                                                style: const TextStyle(
                                                    fontSize: 17.5,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                        FontFamily.sfPro),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 3),
                                              decoration: BoxDecoration(
                                                color:
                                                    AllColors.background_green,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Text(
                                                city.status ?? 'N/A',
                                                style: TextStyle(
                                                  color: AllColors.text__green,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: FontFamily.sfPro,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 13,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  _showBox(context);
                                                },
                                                child: Image.asset(
                                                  ImageStrings.edit,
                                                  height: 16,
                                                  width: 16,
                                                  color: AllColors.figmaGrey,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        // Row(
                                        //   children: [
                                        //   Image.asset(ImageStrings.location,height: 13,width: 13,color: AllColors.mediumPurple,),
                                        //     SizedBox(width: 5),
                                        //     Expanded(
                                        //       child: Text(
                                        //         '${city.state?.name ?? 'Unknown State'}, ${city.state?.country?.name ?? 'Unknown Country'}',
                                        //         style: TextStyle(
                                        //             fontSize: 14,
                                        //             fontWeight: FontWeight.w400,
                                        //             fontFamily: FontFamily.sfPro,
                                        //             color: AllColors.figmaGrey
                                        //         ),
                                        //       ),
                                        //     ),
                                        //
                                        //   ],
                                        // ),

                                        Row(
                                          children: [
                                            Image.asset(
                                              ImageStrings.date,
                                              height: 13,
                                              width: 13,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              formatDateWithDay(
                                                  city.createdAt ?? 'N/A'),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: FontFamily.sfPro,
                                                  color:
                                                      AllColors.mediumPurple),
                                            ),
                                            const Spacer(),
                                            Expanded(
                                              child: Text(
                                                '${city.state?.name ?? 'Unknown State'}, ${city.state?.country?.name ?? 'Unknown Country'}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: FontFamily.sfPro,
                                                  color: AllColors.figmaGrey,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
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
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showBox(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController status = TextEditingController();
    TextEditingController state = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'Edit City',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.sfPro,
                      color: AllColors.blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'City Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.sfPro,
                    color: AllColors.blackColor,
                  ),
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  hintText: 'Enter City Name',
                  controller: name,
                ),
                const SizedBox(height: 5),
                Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.sfPro,
                    color: AllColors.blackColor,
                  ),
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  hintText: 'Status',
                  controller: status,
                  categories: const ["hello", "hello" "hello"],
                ),
                const SizedBox(height: 5),
                Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.sfPro,
                    color: AllColors.blackColor,
                  ),
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  hintText: 'Enter State',
                  controller: state,
                  categories: const ["punjab", "punjab" "punjab"],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  width: 80,
                  height: 30,
                  borderRadius: 25,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.sfPro,
                    ),
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
