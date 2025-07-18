import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart'; // Add Geolocator
import 'package:websuites/utils/components/buttons/common_button.dart';
import '../../../../../../data/models/requestModels/lead/lead_list/details/activities/note/LeadDetailsNoteCreateReqMode.dart';
import '../../../../../../data/models/responseModels/leads/list/details/LeadDetails.dart';
import '../../../../../../resources/imageStrings/image_strings.dart';
import '../../../../../../utils/appColors/app_colors.dart';
import '../../../../../../utils/checkbox/LabeledCheckbox.dart';
import '../../../../../../utils/datetrim/DateTrim.dart';
import '../../../../../../utils/fontfamily/FontFamily.dart';
import '../../../../../../viewModels/globalSetting/GlobalSettingViewModel.dart';
import '../../../../../../viewModels/leadScreens/lead_list/detail/note/LeadDetailsNoteCreateViewModel.dart';
import '../../../../../../viewModels/leadScreens/lead_list/lead_detail_view/activities/notes/LeadDetailsActiNotesViewModel.dart';
import '../../../../createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class LeadActivitiesNotesScreen extends StatefulWidget {
  final String? leadId;
  final LeadDetailsResponseModel leadDetails;

  const LeadActivitiesNotesScreen({
    super.key,
    this.leadId,
    required this.leadDetails,
  });

  @override
  State<LeadActivitiesNotesScreen> createState() => _LeadActivitiesNotesScreenState();
}

class _LeadActivitiesNotesScreenState extends State<LeadActivitiesNotesScreen> {
  final GlobalSettingViewModel globalSettingViewModel = Get.put(GlobalSettingViewModel());
  final LeadDetailsActiNotesViewModel viewModel = Get.put(LeadDetailsActiNotesViewModel());
  final LeadDetailsNoteCreateViewModel noteCreateViewModel = Get.put(LeadDetailsNoteCreateViewModel());
  final TextEditingController remarksController = TextEditingController();
  final RxBool isRemarkInvalid = false.obs;
  bool isAddingNote = false;
  final RxBool smsChecked = false.obs;
  final RxBool mailChecked = false.obs;
  final RxBool whatsappChecked = false.obs;

  @override
  void initState() {
    super.initState();
    globalSettingViewModel.globalSetting.listen((settings) {
      if (settings != null) {
        smsChecked.value = settings.smsEnabled;
        mailChecked.value = settings.mailEnabled;
        whatsappChecked.value = settings.whatsappEnabled;
      }
    });
    if (widget.leadId != null) {
      viewModel.leadDetailsActivitiesNotes(context, widget.leadId!);
    }
  }

  @override
  void dispose() {
    remarksController.dispose();
    super.dispose();
  }

  String formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('MMM d, yyyy • h:mm a').format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }

  // Function to check location permissions and services
  Future<bool> _checkLocationPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled. Please enable them.');
      return false;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied.');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error', 'Location permissions are permanently denied. Please enable them in settings.');
      return false;
    }

    return true;
  }

  // Function to get current location
  Future<Position?> _getCurrentLocation() async {
    try {
      bool hasPermission = await _checkLocationPermissions();
      if (!hasPermission) return null;

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error getting location: $e");
      }
      Get.snackbar('Error', 'Failed to get location: $e');
      return null;
    }
  }

  void handleCreateNote() async {
    if (remarksController.text.trim().isEmpty) {
      isRemarkInvalid.value = true;
      return;
    }
    isRemarkInvalid.value = false;

    // Get current location
    Position? position = await _getCurrentLocation();

    // Call the ViewModel to create the note
    noteCreateViewModel
        .leadDetailsActivitiesNotesCreate(
      remark: remarksController.text.trim(),
      leadId: widget.leadId!,
      isSendSms: smsChecked.value,
      isSendEmail: mailChecked.value,
      isSendWhatsapp: whatsappChecked.value,
      activity: "note", // Set activity as required
      lat: position?.latitude, // Use current latitude or null
      lng: position?.longitude, // Use current longitude or null
    )
        .then((_) {
      // On success, reset the form and UI
      remarksController.clear();
      smsChecked.value = false;
      mailChecked.value = false;
      whatsappChecked.value = false;
      setState(() {
        isAddingNote = false;
      });

      // Refresh the notes list
      if (widget.leadId != null) {
        viewModel.leadDetailsActivitiesNotes(context, widget.leadId!);
      }
    })
        .catchError((error) {
      // Error is already handled in the ViewModel with a snackbar
      isRemarkInvalid.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isAddingNote) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            child: Text(
              "Notes",
              style: TextStyle(
                fontFamily: FontFamily.sfPro,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(child: CommonTextField(hintText: 'Search')),
              const SizedBox(width: 10),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AllColors.mediumPurple),
                ),
                onPressed: () {
                  setState(() {
                    isAddingNote = true;
                  });
                },
                label: const Text('Add', style: TextStyle(color: Colors.white)),
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
        // Use Obx only for the part that depends on viewModel.loading and viewModel.leadActivitiesNotes
        Obx(() {
          if (viewModel.loading.value) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CircularProgressIndicator(),
              ),
            );
          } else if (viewModel.leadActivitiesNotes.isEmpty && !isAddingNote) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'No Notes found',
                  style: TextStyle(
                    fontFamily: FontFamily.sfPro,
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            );
          } else {
            return Column(
              children: [
                if (isAddingNote)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Add Note",
                        style: TextStyle(
                          fontFamily: FontFamily.sfPro,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Remarks *",
                        style: TextStyle(
                          fontFamily: FontFamily.sfPro,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Obx(() => CommonTextField(
                        controller: remarksController,
                        allowCustomBorderInput: BorderRadius.circular(12),
                        hintText: 'Remarks',
                        maxLines: 3,
                        hasError: isRemarkInvalid.value,
                        errorMessage: isRemarkInvalid.value ? 'Remarks cannot be empty' : null,
                        borderColor: isRemarkInvalid.value ? Colors.red : null,
                      )),
                      const SizedBox(height: 10),
                      Obx(() {
                        final settings = globalSettingViewModel.globalSetting.value;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                LabeledCheckbox(
                                  label: 'Send SMS',
                                  value: smsChecked.value,
                                  onChanged: settings?.smsEnabled == true
                                      ? (value) {
                                    smsChecked.value = value ?? false;
                                  }
                                      : (value) {},
                                  activeColor: AllColors.mediumPurple,
                                  labelStyle: TextStyle(
                                    fontFamily: FontFamily.sfPro,
                                    color: AllColors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                LabeledCheckbox(
                                  label: 'Send Mail',
                                  value: mailChecked.value,
                                  onChanged: settings?.mailEnabled == true
                                      ? (value) {
                                    mailChecked.value = value ?? false;
                                  }
                                      : (value) {},
                                  activeColor: AllColors.mediumPurple,
                                  labelStyle: TextStyle(
                                    fontFamily: FontFamily.sfPro,
                                    color: AllColors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                LabeledCheckbox(
                                  label: 'Send WhatsApp',
                                  value: whatsappChecked.value,
                                  onChanged: settings?.whatsappEnabled == true
                                      ? (value) {
                                    whatsappChecked.value = value ?? false;
                                  }
                                      : (value) {},
                                  activeColor: AllColors.mediumPurple,
                                  labelStyle: TextStyle(
                                    fontFamily: FontFamily.sfPro,
                                    color: AllColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(AllColors.vividRed),
                            ),
                            onPressed: () {
                              remarksController.clear();
                              isRemarkInvalid.value = false;
                              setState(() {
                                isAddingNote = false;
                              });
                            },
                            label: const Text('Cancel', style: TextStyle(color: Colors.white)),
                            icon: const Icon(Icons.close, color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          TextButton.icon(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(AllColors.mediumPurple),
                            ),
                            onPressed: noteCreateViewModel.loading.value ? null : handleCreateNote, // Disable during loading
                            label: const Text('Create', style: TextStyle(color: Colors.white)),
                            icon: const Icon(Icons.add, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                if (!isAddingNote)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: viewModel.leadActivitiesNotes.length,
                    separatorBuilder: (context, index) => const Divider(height: 16, thickness: 0.5),
                    itemBuilder: (context, index) {
                      final note = viewModel.leadActivitiesNotes[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: AllColors.background_green,
                                  child: Text(
                                    getInitials(note.createdBy?.firstName ?? '', note.createdBy?.lastName ?? ''),
                                    style: TextStyle(
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${note.createdBy?.firstName ?? ''} ${note.createdBy?.lastName ?? ''}',
                                            style: const TextStyle(
                                              fontFamily: FontFamily.sfPro,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            formatDateTime(note.createdAt.toString()),
                                            style: TextStyle(
                                              fontFamily: FontFamily.sfPro,
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        note.remark ?? '',
                                        style: const TextStyle(
                                          fontFamily: FontFamily.sfPro,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87,
                                        ),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.visible,
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            );
          }
        }),
      ],
    );
  }

  String getInitials(String firstName, String lastName) {
    String initials = '';
    if (firstName.isNotEmpty) {
      initials += firstName[0].toUpperCase();
    }
    if (lastName.isNotEmpty) {
      initials += lastName[0].toUpperCase();
    }
    return initials.isEmpty ? 'NA' : initials;
  }
}