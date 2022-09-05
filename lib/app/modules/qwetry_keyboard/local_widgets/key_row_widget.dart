import 'package:flutter/material.dart';
import 'package:keyboards/app/modules/qwetry_keyboard/local_widgets/key_widget.dart';
import 'package:keyboards/app/providers/qwerty_layout_provider.dart';
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
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: rowElements
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(
                  left: e == rowElements.first ? 0 : horizontalSize * 0.028),
              child: KeyWidget(
                verticalSize: verticalSize,
                horizontalSize: horizontalSize,
                onTap: () async {
                  context.read<QwertyLayoutProvider>().selectedString = e;
                  await context
                      .read<QwertyLayoutProvider>()
                      .predictNextValue(e);
                },
                text: e,
                selectedValue: selectedValue,
              ),
            ),
          )
          .toList(),
    );
  }
}
