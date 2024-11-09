
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize background message handler
  //FirebaseMessaging.onBackgroundMessage(FCMService.backgroundHandler);

  // Initialize FCM Service
  //FCMService fcmService = FCMService();
  //await fcmService.initializeFCM();

  // Initialize UserController and AuthenticationRepository
  //Get.put(UserController());
  //Get.put(AuthenticationRepository());

  runApp(const App());
}
