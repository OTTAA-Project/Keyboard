import 'package:flutter/material.dart';
import 'package:keyboards/app/modules/qwetry_keyboard/local_widgets/key_widget.dart';
import 'package:keyboards/app/providers/qwerty_layout_provider.dart';
import 'package:provider/provider.dart';

class KeyRowWidget extends StatelessWidget {
  const KeyRowWidget({
    Key? key,
    required this.rowElements,
    required this.selectedValue,
    required this.verticalSize,
    required this.horizontalSize,
  }) : super(key: key);
  final List<String> rowElements;
  final String selectedValue;
  final double verticalSize, horizontalSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: rowElements
          .map(
            (e) => KeyWidget(
              verticalSize: verticalSize,
              horizontalSize: horizontalSize,
              onTap: () async {
                context.read<QwertyLayoutProvider>().selectedString = e;
                await context.read<QwertyLayoutProvider>().predictNextValue(e);
              },
              text: e,
              selectedValue: selectedValue,
            ),
          )
          .toList(),
    );
  }
}
