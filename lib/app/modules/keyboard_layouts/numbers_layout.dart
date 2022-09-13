import 'package:flutter/material.dart';
import 'package:keyboard/app/modules/keyboard/local_widgets/key_row_widget.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:provider/provider.dart';

class NumbersLayout extends StatelessWidget {
  const NumbersLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        KeyRowWidget(rowElements: kNumeric.sublist(0, 10), selectedValue: context.watch<KeyboardLayoutProvider>().selectedString),
        const SizedBox(height: 8),
        KeyRowWidget(rowElements: kNumeric.sublist(10, 20), selectedValue: context.watch<KeyboardLayoutProvider>().selectedString),
        const SizedBox(height: 8),
        KeyRowWidget(rowElements: kNumeric.sublist(20), selectedValue: context.watch<KeyboardLayoutProvider>().selectedString),
        const SizedBox(height: 20),
      ],
    );
  }
}
