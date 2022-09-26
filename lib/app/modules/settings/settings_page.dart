import 'package:flutter/material.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:keyboard/app/routes/app_routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          'Ajustes',
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
                leading: const Icon(
                  Icons.record_voice_over,
                  color: kOTTAAOrangeNew,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.settingsVoice);
                },
                title: const Text('Voz y Subtitulos'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.language,
                  color: kOTTAAOrangeNew,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.settingsLang);
                  // Get.to(LanguagePage());
                },
                title: const Text('Idioma'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.accessibility,
                  color: kOTTAAOrangeNew,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.settingsAccessibility);
                },
                title: const Text('Accesibilidad'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.keyboard,
                  color: kOTTAAOrangeNew,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.settingsKeyboard);
                  // Get.to(LanguagePage());
                },
                title: const Text('Teclado'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
