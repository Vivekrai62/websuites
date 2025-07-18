import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import '../../../../data/models/responseModels/master/proposals/master_proposals_resposne_model.dart';
import '../../utils/button/CustomButton.dart';
import '../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../utils/container_Utils/ContainerUtils.dart';
import '../../utils/dark_mode/dark_mode.dart';
import '../../viewModels/master/proposals/master_proposals_viewModel.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:file_picker/file_picker.dart';

class MasterProposalScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const MasterProposalScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<MasterProposalScreen> createState() => _MasterProposalScreenState();
}

class _MasterProposalScreenState extends State<MasterProposalScreen> {
  // Instantiate the ViewModel
  final MasterProposalsViewModel _viewModel =
      Get.put(MasterProposalsViewModel());

  @override
  void initState() {
    super.initState();
    // Fetch proposals when screen loads
    _viewModel.masterProposals(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: DarkMode.backgroundColor(context),
      body: Obx(() {
        if (_viewModel.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // If proposals are not available
        if (_viewModel.proposals.value.isEmpty) {
          return const Center(child: Text('No proposals found'));
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
                      'Proposal',
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
                        _showDialog(context);
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
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Corrected condition: Check if the list is empty
                  if (_viewModel.proposals.value.isEmpty &&
                      !_viewModel.loading.value) {
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
                              itemCount: _viewModel.proposals.value.length + 1,
                              itemBuilder: (context, index) {
                                if (index ==
                                    _viewModel.proposals.value.length) {
                                  return const Center(
                                    child: Text(""),
                                  );
                                }

                                final proposal =
                                    _viewModel.proposals.value[index];
                                return GestureDetector(
                                  onTap: () {},
                                  child: ContainerUtils(
                                    paddingBottom: 0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Title and caretaker
                                        Row(
                                          children: [
                                            Text(
                                              proposal.subject ?? 'Proposal',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: FontFamily.sfPro),
                                            ),
                                            const Spacer(),
                                            Image.asset('assets/icons/edit.png',
                                                height: 17, width: 17),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(Icons.date_range,
                                                size: 15,
                                                color: AllColors.mediumPurple),
                                            const SizedBox(width: 5),
                                            Text(
                                              formatDateWithDay(
                                                  proposal.createdAt ?? 'N/A'),
                                              // Assuming the createdAt field holds the date
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: FontFamily.sfPro,
                                                  color:
                                                      AllColors.mediumPurple),
                                            ),
                                            const Spacer(),
                                            // Edit Icon (Placeholder)
                                            Icon(
                                              Icons.remove_red_eye,
                                              color: AllColors.figmaGrey,
                                              size: 21,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        // Proposal body/content
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
              ),
            ),
          ],
        );
      }),
    );
  }

  void _showDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController body = TextEditingController();
    TextEditingController fileNameController =
        TextEditingController(); // Controller for the file name

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            'Add New Lead Proposal',
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
                        const Text('Subject'),
                        const SizedBox(height: 5),
                        CommonTextField(
                          hintText: 'Enter lead proposal name',
                          controller: nameController,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            CustomButton(
                              height: Get.height / 28,
                              width: 100,
                              backgroundColor: AllColors.greyGoogleForm,
                              child: Text(
                                'Choose files',
                                style: TextStyle(
                                  color: AllColors.blackColor,
                                  fontSize: 12,
                                ),
                              ),
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();
                                if (result != null) {
                                  setState(() {
                                    fileNameController.text = result.files.first
                                        .name; // Update the controller's text
                                  });
                                }
                              },
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 9.0),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  fileNameController.text.isNotEmpty
                                      ? fileNameController.text
                                      : 'No file selected',
                                  // Display the file name or a default message
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(
                              backgroundColor: Colors.grey,
                              width: 80,
                              height: 30,
                              borderRadius: 25,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.sfPro,
                                ),
                              ),
                            ),
                            CustomButton(
                              width: 80,
                              height: 30,
                              borderRadius: 25,
                              onPressed: () {},
                              child: const Text(
                                'Create',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.sfPro,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 1,
                    top: -10,
                    child: Container(
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class RichTextEditorScreen extends StatefulWidget {
  const RichTextEditorScreen({super.key});

  @override
  State<RichTextEditorScreen> createState() => _RichTextEditorScreenState();
}

class _RichTextEditorScreenState extends State<RichTextEditorScreen> {
  final TextEditingController _controller = TextEditingController();
  double _currentFontSize = 14.0;
  FontWeight _currentFontWeight = FontWeight.normal;
  FontStyle _currentFontStyle = FontStyle.normal;
  TextDecoration _currentTextDecoration = TextDecoration.none;
  String _fontFamily = 'Default';
  final TextAlign _textAlign = TextAlign.left;
  final Color _currentTextColor = Colors.black;

  // Track selected formatting options
  int? _selectedHeading;
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderlined = false;
  bool _isMonospace = false;

  void _setHeading(int level) {
    setState(() {
      _selectedHeading = level;
      _currentFontSize =
          14.0 + (6 * (6 - level)); // Adjust font size dynamically
    });
  }

  void _toggleBold() {
    setState(() {
      _isBold = !_isBold;
      _currentFontWeight = _isBold ? FontWeight.bold : FontWeight.normal;
    });
  }

  void _toggleItalic() {
    setState(() {
      _isItalic = !_isItalic;
      _currentFontStyle = _isItalic ? FontStyle.italic : FontStyle.normal;
    });
  }

  void _toggleUnderline() {
    setState(() {
      _isUnderlined = !_isUnderlined;
      _currentTextDecoration =
          _isUnderlined ? TextDecoration.underline : TextDecoration.none;
    });
  }

  void _toggleMonospace() {
    setState(() {
      _isMonospace = !_isMonospace;
      _fontFamily = _isMonospace ? 'monospace' : 'Default';
    });
  }

  void _addUnorderedList() {
    setState(() {
      _controller.text += '\u2022 ';
    });
  }

  void _addOrderedList() {
    final lines = _controller.text.split('\n');
    final numberedText = lines
        .asMap()
        .entries
        .map((entry) => '${entry.key + 1}. ${entry.value}')
        .join('\n');
    setState(() {
      _controller.text = numberedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rich Text Editor'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600, // Card won't exceed 600px in width
            ),
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    // Toolbar
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          // Heading buttons
                          for (int i = 1; i <= 6; i++)
                            TextButton(
                              onPressed: () => _setHeading(i),
                              style: TextButton.styleFrom(
                                backgroundColor: _selectedHeading == i
                                    ? AllColors.mediumPurple
                                    : Colors.white,
                                foregroundColor: Colors.grey, // Gray text color
                                padding: EdgeInsets.zero, // Remove padding
                              ),
                              child: Text('H$i'),
                            ),
                          IconButton(
                            icon: const Icon(Icons.format_bold),
                            onPressed: _toggleBold,
                            color: _isBold ? AllColors.mediumPurple : null,
                          ),
                          IconButton(
                            icon: const Icon(Icons.format_italic),
                            onPressed: _toggleItalic,
                            color: _isItalic ? AllColors.mediumPurple : null,
                          ),
                          IconButton(
                            icon: const Icon(Icons.format_underline),
                            onPressed: _toggleUnderline,
                            color:
                                _isUnderlined ? AllColors.mediumPurple : null,
                          ),
                          IconButton(
                            icon: const Icon(Icons.format_list_bulleted),
                            onPressed: _addUnorderedList,
                          ),
                          IconButton(
                            icon: const Icon(Icons.format_list_numbered),
                            onPressed: _addOrderedList,
                          ),
                          IconButton(
                            icon: const Icon(Icons.code),
                            onPressed: _toggleMonospace,
                            color: _isMonospace ? AllColors.mediumPurple : null,
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 20, thickness: 2),
                    // Editor
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontSize: _currentFontSize,
                          fontWeight: _currentFontWeight,
                          fontStyle: _currentFontStyle,
                          decoration: _currentTextDecoration,
                          fontFamily:
                              _fontFamily == 'monospace' ? 'Courier' : null,
                          color: _currentTextColor,
                        ),
                        textAlign: _textAlign,
                        decoration: const InputDecoration(
                          hintText: 'Write here...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
