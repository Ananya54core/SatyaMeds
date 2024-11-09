import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:satyameds/utils/theme/custom_theme/theme.dart';

import 'onboarding_screen/onboarding_screen/boarding.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: VAppTheme.lightTheme,
      darkTheme: VAppTheme.darkTheme,
      home: const OnBoardingScreen(), // Set the onboarding screen as the home
      debugShowCheckedModeBanner: false, // Remove the debug banner
    );
  }
}