import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:satyameds/appointmet/appointment_screen.dart';
import 'package:satyameds/store/storeui.dart';
import 'package:satyameds/utils/constants/colors.dart';
import 'package:satyameds/utils/constants/helperfunctions.dart';
import 'package:satyameds/settings/settings.dart';
import 'home.dart';
import 'dart:io';
import 'package:satyameds/mainscreen/scanner/mainpage.dart';

class Navigationmenu extends StatelessWidget {
  const Navigationmenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkmode = THelperFunction.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
          controller.selectedIndex.value = index,
          backgroundColor: darkmode ? TColors.black :Colors.indigo[50],
          indicatorColor: darkmode
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.shop), label: 'Store'),
            NavigationDestination(
                icon: Icon(Icons.medical_services_outlined), label: 'Doctor'),
            NavigationDestination(icon: Icon(Icons.person), label: 'User'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.openCamera(context),
        backgroundColor: Colors.indigoAccent,
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    MedicinalPlantStoreScreen(),
    AppointmentScreen(),
    UserAccountScreen(),

  ];

  final ImagePicker _picker = ImagePicker();

  void openCamera(BuildContext context) async {
    // Get the list of available cameras
    final cameras = await availableCameras();

    // Navigate to the MainPage with the camera list
    if (cameras.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(cameras: cameras),
        ),
      );
    }
  }

  void _showGalleryOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Ensures full-screen modal
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height, // Full screen height
        width: MediaQuery.of(context).size.width, // Full screen width
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logos/plant_scan.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ElevatedButton.icon(
            onPressed: () async {
              final XFile? galleryImage = await _picker.pickImage(
                source: ImageSource.gallery,
              );
              if (galleryImage != null) {
                // Handle the gallery image
                print('Gallery image path: ${galleryImage.path}');
                Get.back(); // Close the bottom sheet
              }
            },
            icon: const Icon(Iconsax.gallery),
            label: const Text('Upload from Gallery'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.white.withOpacity(0.8), // Semi-transparent background
              foregroundColor: Colors.black, // Text and icon color
              elevation: 5,
            ),
          ),
        ),
      ),
    );
  }
}

