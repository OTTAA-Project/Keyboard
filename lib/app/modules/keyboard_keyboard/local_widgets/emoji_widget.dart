import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:provider/provider.dart';

class EmojiWidget extends StatelessWidget {
  final Emoji emoji;
  final int index;

  const EmojiWidget({Key? key, required this.emoji, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaleFactor = (size.width * size.aspectRatio) / (size.height * size.aspectRatio);
    return GestureDetector(
      onTap: () async {
        await context.read<KeyboardLayoutProvider>().predictNextValue(emoji.char);
      },
      child: Text(
        emoji.char,
        textScaleFactor: scaleFactor,
      ),
    );
  }
}
