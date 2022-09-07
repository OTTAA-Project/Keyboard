import 'package:flutter/material.dart';
import 'package:keyboard/app/modules/keyboard_keyboard/local_widgets/key_widget.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:provider/provider.dart';

class KeyRowWidget extends StatelessWidget {
  const KeyRowWidget({
    Key? key,
    required this.rowElements,
    required this.selectedValue,
  }) : super(key: key);

  final List<String> rowElements;
  final String selectedValue;

  // final double verticalSize, horizontalSize;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = (size.width / rowElements.length) - 40; // -40 for padding
    double screenHeight = size.height;
    final height = screenHeight * 0.1;

    return SizedBox(
      width: size.width,
      child: Wrap(
        spacing: 10,
        runSpacing: 5,
        runAlignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        children: rowElements
            .map(
              (letter) => KeyWidget(
                text: letter,
                onTap: () async {
                  context.read<KeyboardLayoutProvider>().selectedString = letter;

                  await context.read<KeyboardLayoutProvider>().predictNextValue(letter);
                },
                selectedValue: selectedValue,
                height: height,
                width: width,
              ),
            )
            .toList(),
      ),
    );
  }
}
