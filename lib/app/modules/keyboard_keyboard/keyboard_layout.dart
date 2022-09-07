import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard/app/data/enums/keyboard_layout.dart';
import 'package:keyboard/app/modules/keyboard_keyboard/local_widgets/local_widgets.dart';
import 'package:keyboard/app/modules/keyboard_layouts/emojis_layout.dart';
import 'package:keyboard/app/modules/keyboard_layouts/numbers_layout.dart';
import 'package:keyboard/app/modules/keyboard_layouts/qwerty_layout.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:keyboard/app/themes/app_theme.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:provider/provider.dart';

const keyboardLayouts = [QwertyLayout(), EmojisLayout(), NumbersLayout()];

class KeyboardLayoutScreen extends StatelessWidget {
  const KeyboardLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final verticalSize = size.height;
    final horizontalSize = size.width;

    return Scaffold(
      // drawer: Padding(
      //   padding: EdgeInsets.symmetric(vertical: verticalSize * 0.03),
      //   child: Container(
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.only(
      //         topRight: Radius.circular(horizontalSize * 0.02),
      //         bottomRight: Radius.circular(horizontalSize * 0.02),
      //       ),
      //     ),
      //     height: verticalSize,
      //     width: horizontalSize * 0.4,
      //     child: Column(
      //       children: [
      //         ListTile(
      //           leading: const Icon(Icons.settings),
      //           title: const Text('Settings'),
      //           onTap: () {
      //             Navigator.pushNamed(context, '/settings');
      //           },
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      drawer: const DrawerWidget(),
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryMaterialColor.shade700,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalSize * 0.03,
            vertical: verticalSize * 0.03,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    TextInputWidget(
                      controller: context.watch<KeyboardLayoutProvider>().qwertyController,
                      height: verticalSize,
                      width: horizontalSize,
                      // focusNode: context.read<QwertyLayoutProvider>().focusNode,
                    ),
                    keyboardLayouts[context.watch<KeyboardLayoutProvider>().currentLayout.index],
                    SizedBox(
                      width: horizontalSize,
                      height: verticalSize * 0.1,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //todo: Atras onTap
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () async {
                                // await context
                                //     .read<QwertyLayoutProvider>()
                                //     .getTheModelsList();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(verticalSize * 0.01),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Atrás',
                                    textScaleFactor: 1.5,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // space button
                          Expanded(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () async => await context.read<KeyboardLayoutProvider>().addSpace(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(verticalSize * 0.01),
                                ),
                              ),
                            ),
                          ),

                          //todo: smiley onTap
                          if (context.read<KeyboardLayoutProvider>().currentLayout != KeyboardLayout.emojis) ...[
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  context.read<KeyboardLayoutProvider>().onChangeKeyboardLayout(KeyboardLayout.emojis);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kButtonColor,
                                    borderRadius: BorderRadius.circular(verticalSize * 0.01),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.emoji_emotions_outlined,
                                      size: verticalSize * 0.06,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(
                            width: 10,
                          ),

                          //todo: qwerty onTap
                          if (context.read<KeyboardLayoutProvider>().currentLayout != KeyboardLayout.qwerty) ...[
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  context.read<KeyboardLayoutProvider>().onChangeKeyboardLayout(KeyboardLayout.qwerty);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kButtonColor,
                                    borderRadius: BorderRadius.circular(verticalSize * 0.01),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.abc,
                                      size: verticalSize * 0.06,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],

                          //!todo: numbers onTap

                          if (context.read<KeyboardLayoutProvider>().currentLayout != KeyboardLayout.numbers) ...[
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  context.read<KeyboardLayoutProvider>().onChangeKeyboardLayout(KeyboardLayout.numbers);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kButtonColor,
                                    borderRadius: BorderRadius.circular(verticalSize * 0.01),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '123',
                                      textScaleFactor: 2,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        height: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],

                          //todo: upArrow onTap
                          Expanded(
                            child: GestureDetector(
                              onTap: () => {},
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(verticalSize * 0.01),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_upward,
                                    size: verticalSize * 0.06,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // //todo: arrowForward onTap
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () async => context.read<KeyboardLayoutProvider>().updateHints(),
                              child: Container(
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
                          ),
                        ],
                      ),
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
                ),
              ),

              SizedBox(
                width: horizontalSize * 0.03,
              ),

              //Prediction
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await context.read<KeyboardLayoutProvider>().speakSentenceAndSendItToLearn();
                      },
                      child: Container(
                        height: verticalSize * 0.2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kButtonColor,
                          borderRadius: BorderRadius.circular(verticalSize * 0.02),
                        ),
                        child: Icon(
                          Icons.volume_up_sharp,
                          color: Colors.white54,
                          size: verticalSize * 0.09,
                        ),
                      ),
                    ),

                    /// first one
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: verticalSize * 0.03),
                      child: PredictionWidget(
                        verticalSize: verticalSize,
                        text: context.watch<KeyboardLayoutProvider>().hintsValues[0],
                        onTap: context.watch<KeyboardLayoutProvider>().hintsValues[0] == ''
                            ? () {}
                            : () async => context.read<KeyboardLayoutProvider>().addHintToSentence(
                                  text: context.read<KeyboardLayoutProvider>().hintsValues[0],
                                ),
                      ),
                    ),

                    /// second value
                    PredictionWidget(
                      verticalSize: verticalSize,
                      text: context.watch<KeyboardLayoutProvider>().hintsValues[1],
                      onTap: context.watch<KeyboardLayoutProvider>().hintsValues[1] == ''
                          ? () {}
                          : () async => context.read<KeyboardLayoutProvider>().addHintToSentence(
                                text: context.read<KeyboardLayoutProvider>().hintsValues[1],
                              ),
                    ),

                    ///third value
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: verticalSize * 0.03),
                      child: PredictionWidget(
                        verticalSize: verticalSize,
                        text: context.watch<KeyboardLayoutProvider>().hintsValues[2],
                        onTap: context.watch<KeyboardLayoutProvider>().hintsValues[2] == ''
                            ? () {}
                            : () async => context.read<KeyboardLayoutProvider>().addHintToSentence(
                                  text: context.read<KeyboardLayoutProvider>().hintsValues[2],
                                ),
                      ),
                    ),

                    ///fourth value
                    PredictionWidget(
                      verticalSize: verticalSize,
                      text: context.watch<KeyboardLayoutProvider>().hintsValues[3],
                      onTap: context.watch<KeyboardLayoutProvider>().hintsValues[3] == ''
                          ? () {}
                          : () async => context.read<KeyboardLayoutProvider>().addHintToSentence(
                                text: context.read<KeyboardLayoutProvider>().hintsValues[3],
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
