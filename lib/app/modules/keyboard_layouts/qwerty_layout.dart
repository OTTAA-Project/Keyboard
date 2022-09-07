import 'package:flutter/material.dart';
import 'package:keyboard/app/data/enums/keyboard_layout.dart';
import 'package:keyboard/app/global_controllers/tts_controller.dart';
import 'package:keyboard/app/modules/keyboard_keyboard/local_widgets/key_row_widget.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:keyboard/app/themes/app_theme.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:provider/provider.dart';

class QwertyLayout extends StatelessWidget {
  const QwertyLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final verticalSize = size.height;
    final horizontalSize = size.width;

    return Column(
      children: [
        const SizedBox(height: 20),
        KeyRowWidget(rowElements: kLetters.sublist(0, 10), selectedValue: context.watch<KeyboardLayoutProvider>().selectedString),
        const SizedBox(height: 8),
        KeyRowWidget(rowElements: kLetters.sublist(10, 20), selectedValue: context.watch<KeyboardLayoutProvider>().selectedString),
        const SizedBox(height: 8),
        KeyRowWidget(rowElements: kLetters.sublist(20), selectedValue: context.watch<KeyboardLayoutProvider>().selectedString),
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
                context.read<KeyboardLayoutProvider>().onChangeKeyboardLayout(KeyboardLayout.emojis);
              },
              child: Container(
                height: verticalSize * 0.1,
                width: horizontalSize * 0.05,
                decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(verticalSize * 0.01),
                ),
                child: Icon(
                  Icons.emoji_emotions_outlined,
                  size: verticalSize * 0.06,
                  color: Colors.white,
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
        SizedBox(
          height: verticalSize * 0.04,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.02),
          decoration: const BoxDecoration(
            color: kButtonColor,
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            // value: _.isEnglish.value ? 'English' : 'Spanish',
            value: context.watch<KeyboardLayoutProvider>().modelType,
            iconSize: 20,
            elevation: 16,
            underline: Container(),
            onChanged: (newValue) {
              context.read<KeyboardLayoutProvider>().onChangedDropDownMenu(value: newValue!);
            },
            dropdownColor: kPrimaryMaterialColor.shade700,
            items: context.read<KeyboardLayoutProvider>().isModelTypeDataLoaded
                ?
                // DropdownMenuItem(
                //   child: Text('English'),
                //   value: 'English',
                // ),
                context
                    .read<KeyboardLayoutProvider>()
                    .modelTypeModel
                    .value
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(
                          e,
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: e,
                      ),
                    )
                    .toList()
                : [],
          ),
        ),
      ],
    );
  }
}
