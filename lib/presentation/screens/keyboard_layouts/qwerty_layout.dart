import 'package:flutter/material.dart';
import 'package:keyboard/application/common/constants.dart';
import 'package:keyboard/core/enums/keyboard_layouts.dart';
import 'package:keyboard/presentation/screens/keyboard/local_widgets/key_row_widget.dart';
import 'package:keyboard/application/providers/keyboard_layout_provider.dart';
import 'package:keyboard/application/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class QwertyLayout extends StatelessWidget {
  const QwertyLayout({Key? key}) : super(key: key);

  List<String> secualizeLayout(KeyboardLayout type) {
    switch (type) {
      case KeyboardLayout.keypad:
      case KeyboardLayout.abc:
        return kABCLayout;
      case KeyboardLayout.qwerty:
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
