import 'package:flutter/material.dart';
import 'package:keyboard/app/providers/settings_provider.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'local_widgets/build_app_bar.dart';

class KeyboardPage extends StatelessWidget {
  const KeyboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SettingsProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar('Teclado'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Keyboard layout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Divider(
              height: 10,
              color: Colors.grey[700],
            ),
            const SizedBox(height: 10),
            ...kKeyboardLayouts.keys.map((layoutKey) {
              return RadioListTile<String>(
                title: Text(layoutKey),
                subtitle: Text(kKeyboardLayouts[layoutKey]!),
                value: layoutKey,
                groupValue: provider.keyboardLayout,
                onChanged: layoutKey == 'Keypad'
                    ? null
                    : (String? value) {
                        if (value != null && value != provider.keyboardLayout) {
                          provider.updateKeyboardLayout(value);
                        }
                      },
              );
            })
          ],
        ),
      ),
    );
  }
}
