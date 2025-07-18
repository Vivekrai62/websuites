import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/appColors/app_colors.dart';
import '../../../../utils/components/buttons/common_button.dart';
import '../../../../utils/fontfamily/FontFamily.dart';
import '../../../homeScreen/home_manager/HomeManagerScreen.dart';

class MapScreen extends StatelessWidget {
  final double latitude;
  final double longitude;
  final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  final Rx<LatLng> targetLocation = Rx<LatLng>(const LatLng(0, 0));
  final RxDouble currentZoom = 12.0.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLocationEnabled = false.obs;
  final Location location = Location();
  final String username;
  final homeController = Get.find<HomeManagerController>();

  MapScreen({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.username,
  }) {
    targetLocation.value = LatLng(latitude, longitude);
    _initializeLocation();
  }

  void _initializeLocation() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) return;
      }

      var permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return;
      }

      isLocationEnabled.value = true;
    } catch (e) {
      print('Error setting up location services: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: targetLocation.value,
                  zoom: currentZoom.value,
                ),
                onMapCreated: (GoogleMapController controller) {
                  if (mapController.value == null) {
                    mapController.value = controller;
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(latitude, longitude),
                          zoom: currentZoom.value,
                        ),
                      ),
                    );
                  }
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("Current Position"),
                    position: targetLocation.value,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                    onTap: () => showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.location_on_outlined,
                                            color: AllColors.vividRed,
                                            size: 18),
                                        const SizedBox(width: 5),
                                        const Text(
                                          'Location Details:- ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: FontFamily.sfPro),
                                        ),
                                        Text(
                                          username,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: FontFamily.sfPro,
                                            color: AllColors.figmaGrey,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      '09 Jan, 2025 06:31 AM',
                                      style: TextStyle(
                                        fontFamily: FontFamily.sfPro,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      'Coordinates: ${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: FontFamily.sfPro),
                                    ),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CommonButton(
                                            color: AllColors.vividRed,
                                            height: 35,
                                            width: 110,
                                            title: 'Close',
                                            onPress: () => Get.back(),
                                          ),
                                          const SizedBox(width: 20),
                                          CommonButton(
                                            height: 35,
                                            width: 110,
                                            color: AllColors.greenJungle,
                                            title: 'Get Details',
                                            onPress: () async {
                                              final url =
                                                  'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                                              try {
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              } catch (e) {
                                                print(
                                                    'Error launching maps: $e');
                                                Get.snackbar(
                                                  'Error',
                                                  'Could not open maps application',
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 1,
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
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.close,
                                        color: Colors.black, size: 14),
                                    onPressed: () {
                                      homeController
                                          .resetOrderDetails(); // Reset the details
                                      Get.back(); // Close the dialog
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                },
                myLocationEnabled: isLocationEnabled.value,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onCameraMove: (CameraPosition position) {
                  currentZoom.value = position.zoom;
                },
              )),
          Positioned(
            right: 16,
            bottom: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: "zoomIn",
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    if (currentZoom.value >= 20.0) return;
                    currentZoom.value += 1.0;
                    mapController.value?.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: targetLocation.value,
                          zoom: currentZoom.value,
                        ),
                      ),
                    );
                  },
                  backgroundColor: Colors.white,
                  mini: true,
                  child: const Icon(Icons.add, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: "zoomOut",
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    if (currentZoom.value <= 1.0) return;
                    currentZoom.value -= 1.0;
                    mapController.value?.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: targetLocation.value,
                          zoom: currentZoom.value,
                        ),
                      ),
                    );
                  },
                  backgroundColor: Colors.white,
                  mini: true,
                  child: const Icon(Icons.remove, color: Colors.black54),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            top: MediaQuery.of(context).padding.top + 10,
            child: FloatingActionButton(
              heroTag: "backButton",
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () {
                homeController
                    .resetOrderDetails(); // Reset the details when going back
                Get.back(); // Navigate back to UserActivityScreen
              },
              backgroundColor: Colors.white,
              mini: true,
              child: const Icon(Icons.close, color: Colors.black54),
            ),
          ),
          Obx(() => isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
