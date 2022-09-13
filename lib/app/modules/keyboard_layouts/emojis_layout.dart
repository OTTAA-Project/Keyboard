import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:keyboard/app/data/enums/keyboard_layout.dart';
import 'package:keyboard/app/modules/keyboard_keyboard/local_widgets/emoji_widget.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:provider/provider.dart';

class EmojisLayout extends StatelessWidget {
  const EmojisLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Emoji> emojis = Emoji.all();

    final size = MediaQuery.of(context).size;

    final verticalSize = size.height;
    final horizontalSize = size.width;

    return Column(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          height: size.height * 0.5,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
              mainAxisExtent: 50,
            ),
            itemCount: emojis.length,
            itemBuilder: (_, index) {
              final emoji = emojis[index];
              return EmojiWidget(emoji: emoji.char);
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //todo: Atras onTap
            GestureDetector(
              onTap: () async {
                // await context
                //     .read<QwertyLayoutProvider>()
                //     .getTheModelsList();
              },
              child: Container(
                height: verticalSize * 0.1,
                width: horizontalSize * 0.128,
                decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(verticalSize * 0.01),
                ),
                child: const Center(
                  child: Text(
                    'Atras',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ),

            /// space button
            GestureDetector(
              onTap: () async => await context.read<KeyboardLayoutProvider>().addSpace(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.028),
                child: Container(
                  height: verticalSize * 0.1,
                  width: horizontalSize * 0.205,
                  decoration: BoxDecoration(
                    color: kButtonColor,
                    borderRadius: BorderRadius.circular(verticalSize * 0.01),
                  ),
                ),
              ),
            ),
            //todo: smiley onTap
            GestureDetector(
              onTap: () {
                context.read<KeyboardLayoutProvider>().onChangeKeyboardLayout(KeyboardLayout.qwerty);
              },
              child: Container(
                height: verticalSize * 0.1,
                width: horizontalSize * 0.05,
                decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(verticalSize * 0.01),
                ),
                child: const Center(
                  child: Text(
                    'ABC',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: horizontalSize * 0.028,
            ),
            // //!todo: numbers onTap

            GestureDetector(
              onTap: () async {
                // await context
                //     .read<QwertyLayoutProvider>()
                //     .getTheModelsList();
              },
              child: Container(
                height: verticalSize * 0.1,
                width: horizontalSize * 0.05,
                decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(verticalSize * 0.01),
                ),
                child: const Center(
                  child: Text(
                    '123',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: horizontalSize * 0.028,
            ),
            //todo: upArrow onTap
            GestureDetector(
              child: Container(
                height: verticalSize * 0.1,
                width: horizontalSize * 0.05,
                decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(verticalSize * 0.01),
                ),
                child: Icon(
                  Icons.arrow_upward,
                  size: verticalSize * 0.06,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: horizontalSize * 0.028,
            ),
            //todo: arrowForward onTap
            GestureDetector(
              onTap: () async => context.read<KeyboardLayoutProvider>().updateHints(),
              child: Container(
                height: verticalSize * 0.1,
                width: horizontalSize * 0.128,
                decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(verticalSize * 0.01),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward,
                    size: verticalSize * 0.08,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
