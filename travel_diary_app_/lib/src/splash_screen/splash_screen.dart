import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../sample_feature/sample_item_details_view.dart';
import '../sample_feature/sample_item_list_view.dart';
import '../settings/settings_controller.dart';
import '../settings/settings_view.dart';

import '../authentication/login_view.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key});

  

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // Replace 'settingsService' with the actual service/object required by SettingsController.
  // If it's a service or dependency, ensure it's properly instantiated or provided.
  // final SettingsController settingsController = SettingsController(settingsService);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        // builder: (_) => const SampleItemListView(), // Default view
        builder: (_) => const LoginView(), // Default view
      ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Full-screen blue background
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Image.asset('assets/logo.png'), // Replace with your local image path
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Text(
              'Goodboys',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
