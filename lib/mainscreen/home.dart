import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:satyameds/mainscreen/chatbot/chatbot_ui.dart';
import 'package:satyameds/mainscreen/disease_screen.dart';
import 'package:satyameds/mainscreen/drugvisualizer.dart';
import 'package:satyameds/mainscreen/primaryheader.dart';
import 'package:satyameds/mainscreen/promoslider.dart';
import 'package:satyameds/mainscreen/searchbar.dart';
import 'package:satyameds/utils/constants/colors.dart';
import 'package:satyameds/utils/constants/helperfunctions.dart';
import 'package:satyameds/utils/constants/image_strings.dart';
import 'package:satyameds/utils/constants/text_sizes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'library.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TPrimaryHeaderContainer(
              height: 400,
              child: Column(
                children: [
                  SizedBox(height: TextSizes.spacebtwSections),

                  TSearchContainer(
                    text: "Search with Satya Meds",
                    borderColor: dark ? TColors.dark : TColors.dark,
                  ),

                  // SizedBox(height: TextSizes.spacebtwSections), // You can uncomment this if needed

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: TextSizes.spacebtwSections),
                      child: _buildImageButtons(context),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(TextSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(
                    banners: [
                      TImages.banner1,
                      TImages.banner2,
                      TImages.banner3,
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(height: 5), // Move this line inside the Column
                  GestureDetector(
                    onTap: () {
                      final link = "https://community-section.vercel.app/";
                      launchUrl(Uri.parse(link), mode: LaunchMode.inAppWebView);
                    }, // Navigate to another screen
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage('assets/onboarding/community.png'), // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Community',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.7),
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() =>  ChatScreen()),
        backgroundColor: Colors.indigoAccent,
        child: const Icon(Icons.android),
      ),
    );
  }

  Widget _buildImageButtons(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      // Reduced spacing
      mainAxisSpacing: 15,
      // Reduced spacing
      childAspectRatio: 1.2,
      // Adjusted for better fit
      children: [
        _buildImageButton(
          context: context,
          imagePath: 'assets/logos/scan.png',
          label: "Med Scanner",
          onTap: () {final link = "https://satya-meds.vercel.app/";
          launchUrl(Uri.parse(link), mode: LaunchMode.inAppWebView);},
        ),
        _buildImageButton(
          context: context,
          imagePath: 'assets/logos/book.png',
          label: "E-library",
          onTap: () =>Get.to(()=>MedicineLibraryScreen()),
        ),
        _buildImageButton(
          context: context,
          imagePath: 'assets/logos/physiology.png',
          label: "Drug Visualizer",
          onTap: (){final link = "https://deep-v.itch.io/med";
          launchUrl(Uri.parse(link), mode: LaunchMode.inAppWebView);} ,
        ),
        _buildImageButton(
          context: context,
          imagePath: 'assets/logos/pills.png',
          label: "Symptoms Cure",
          onTap: () => Get.to(()=>SymptomCheckerApp()),
        ),
      ],
    );
  }

  Widget _buildImageButton({
    required BuildContext context,
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.white.withOpacity(0.1) : Colors
        .white.withOpacity(0.1);
    final textColor = isDark ? Colors.white : Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12), // Reduced border radius
        child: Container(
          padding: const EdgeInsets.all(8), // Reduced padding
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12), // Reduced border radius
            border: Border.all(
              color: isDark ? Colors.white.withOpacity(0.1) : Colors
                  .indigoAccent.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8), // Reduced padding
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  imagePath,
                  width: 50, // Adjusted image size
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 11), // Reduced spacing
              Text(
                label,
                style: TextStyle(
                  fontSize: 14, // Reduced font size
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}