import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:keyboard/app/modules/keyboard/local_widgets/emoji_widget.dart';

class EmojisLayout extends StatelessWidget {
  const EmojisLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Emoji> emojis = Emoji.all();

    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height - (size.height * 0.5),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 30,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
                mainAxisExtent: 50,
              ),
              itemCount: emojis.length,
              itemBuilder: (_, index) {
                final emoji = emojis[index];
                return EmojiWidget(emoji: emoji, index: index);
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
