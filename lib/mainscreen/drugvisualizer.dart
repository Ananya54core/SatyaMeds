import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GameScreen extends StatelessWidget {
  final String gameImage = 'assets/onboarding/game.gif'; // Replace with your image asset

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image covering the screen
          Positioned.fill(
            child: Image.asset(
              gameImage,
              fit: BoxFit.cover,
            ),
          ),

          // Button at the bottom
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  final link = "https://deep-v.itch.io/med";
                  launchUrl(Uri.parse(link), mode: LaunchMode.inAppBrowserView);
                },

                child: Text(
                  'Play Now',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}