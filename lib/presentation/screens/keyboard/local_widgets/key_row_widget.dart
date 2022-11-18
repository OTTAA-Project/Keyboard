import 'package:flutter/material.dart';
import 'package:keyboard/presentation/screens/keyboard/local_widgets/key_widget.dart';
import 'package:keyboard/application/providers/keyboard_layout_provider.dart';
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
    // double width = (size.width / rowElements.length) - (40 * size.aspectRatio); // -40 for padding
    double screenHeight = size.height;
    final height = screenHeight * 0.1;

    return SizedBox(
      width: size.width,
      height: height,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        verticalDirection: VerticalDirection.up,
        children: rowElements.map(
          (letter) {
            int index = rowElements.indexOf(letter);

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: index != 0 ? 4 : 0, right: index != rowElements.length - 1 ? 4 : 0),
                child: KeyWidget(
                  text: letter,
                  onTap: () async {
                    context.read<KeyboardLayoutProvider>().selectedString = letter;
                    await context.read<KeyboardLayoutProvider>().predictNextValue(letter);
                  },
                  selectedValue: selectedValue,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
