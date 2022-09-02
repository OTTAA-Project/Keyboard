import 'package:flutter/material.dart';
import 'package:keyboards/app/routes/app_routes.dart';
import 'package:keyboards/app/utils/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        // leading: Placeholder(),
        centerTitle: false,
        backgroundColor: Colors.grey[350],
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
              const Text(
                'SETTINGS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey[700],
              ),
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
