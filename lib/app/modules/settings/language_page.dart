import 'package:flutter/material.dart';
import 'package:keyboard/app/providers/settings_provider.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'local_widgets/build_app_bar.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar('Language'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'LANGUAGE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Divider(
              height: 10,
              color: Colors.grey[700],
            ),
            DropdownButton<String>(
                isExpanded: true,
                value: context.watch<SettingsProvider>().clientLanguage,
                iconSize: 20,
                elevation: 16,
                underline: Container(),
                onChanged: context.watch<SettingsProvider>().changeClientLanguage,
                items: kLanguages
                    .map((e) => DropdownMenuItem(
                          child: Text(e['name']!),
                          value: e['code'],
                        ))
                    .toList()),
          ],
        ),
      ),
    );
  }
}
