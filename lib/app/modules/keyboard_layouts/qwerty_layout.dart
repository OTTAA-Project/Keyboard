import 'package:flutter/material.dart';
import 'package:keyboard/app/modules/keyboard/local_widgets/key_row_widget.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:keyboard/app/providers/settings_provider.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:provider/provider.dart';

class QwertyLayout extends StatelessWidget {
  const QwertyLayout({Key? key}) : super(key: key);

  List<String> secualizeLayout(String type) {
    switch (type) {
      case 'Keypad':
      case 'ABC':
        return kABCLayout;
      case 'Qwerty':
      default:
        return kQWERTYLayout;
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO: toggle caps lock

    final settingsProvider = context.watch<SettingsProvider>();

    final currentLayout = secualizeLayout(settingsProvider.keyboardLayout);

    if (settingsProvider.keyboardLayout == 'Keypad') {
      //TODO: add keypad layout
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 20),
          KeyRowWidget(rowElements: currentLayout.sublist(0, 10), selectedValue: context.watch<KeyboardLayoutProvider>().selectedString),
          const SizedBox(height: 8),
          KeyRowWidget(rowElements: currentLayout.sublist(10, 20), selectedValue: context.watch<KeyboardLayoutProvider>().selectedString),
          const SizedBox(height: 8),
          KeyRowWidget(rowElements: currentLayout.sublist(20), selectedValue: context.watch<KeyboardLayoutProvider>().selectedString),
          const SizedBox(height: 20),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 20),
        KeyRowWidget(rowElements: currentLayout.sublist(0, 10), selectedValue: context.watch<KeyboardLayoutProvider>().selectedString),
        const SizedBox(height: 8),
        KeyRowWidget(rowElements: currentLayout.sublist(10, 20), selectedValue: context.watch<KeyboardLayoutProvider>().selectedString),
        const SizedBox(height: 8),
        KeyRowWidget(rowElements: currentLayout.sublist(20), selectedValue: context.watch<KeyboardLayoutProvider>().selectedString),
        const SizedBox(height: 20),
      ],
    );
  }
}
