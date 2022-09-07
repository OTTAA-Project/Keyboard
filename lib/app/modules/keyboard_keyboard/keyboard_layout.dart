import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard/app/modules/keyboard_keyboard/local_widgets/local_widgets.dart';
import 'package:keyboard/app/modules/keyboard_layouts/emojis_layout.dart';
import 'package:keyboard/app/modules/keyboard_layouts/numbers_layout.dart';
import 'package:keyboard/app/modules/keyboard_layouts/qwerty_layout.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:keyboard/app/themes/app_theme.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:provider/provider.dart';

class KeyboardLayoutScreen extends StatefulWidget {
  const KeyboardLayoutScreen({Key? key}) : super(key: key);

  @override
  State<KeyboardLayoutScreen> createState() => _KeyboardLayoutScreenState();
}

class _KeyboardLayoutScreenState extends State<KeyboardLayoutScreen> {
  @override
  void initState() {
    Future.wait([
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky),
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
    ]).then((value) => setState(() {}));
    super.initState();
  }

  final keyboardLayouts = [const QwertyLayout(), const EmojisLayout(), const NumbersLayout()];

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
