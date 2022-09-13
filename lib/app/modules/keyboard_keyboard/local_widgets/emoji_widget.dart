import 'package:flutter/material.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:provider/provider.dart';

class EmojiWidget extends StatelessWidget {
  final String emoji;

  const EmojiWidget({Key? key, required this.emoji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.read<KeyboardLayoutProvider>().predictNextValue(emoji);
      },
      child: Text(emoji, textScaleFactor: 2),
    );
  }
}
