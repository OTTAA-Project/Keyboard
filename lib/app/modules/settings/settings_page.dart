import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:keyboard/app/routes/app_routes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Settings',
        ),
        // leading: Placeholder(),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 40,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.record_voice_over,
                  color: kOTTAAOrangeNew,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.SETTINGS_VOICE);
                },
                title: const Text('Voice and Subtitles'),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: kOTTAAOrangeNew,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.SETTINGS_LANG);
                  // Get.to(LanguagePage());
                },
                title: const Text('Language'),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
