import 'package:flutter/material.dart';
import 'package:keyboards/app/modules/qwetry_keyboard/local_widgets/key_row_widget.dart';
import 'package:keyboards/app/modules/qwetry_keyboard/local_widgets/key_widget.dart';
import 'package:keyboards/app/modules/qwetry_keyboard/local_widgets/prediction_widget.dart';
import 'package:keyboards/app/modules/qwetry_keyboard/local_widgets/text_input_widget.dart';
import 'package:keyboards/app/providers/qwerty_layout_provider.dart';
import 'package:provider/provider.dart';

class QwertyLayout extends StatelessWidget {
  const QwertyLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
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
                      controller: context
                          .watch<QwertyLayoutProvider>()
                          .qwertyController,
                      height: verticalSize,
                      width: horizontalSize,
                      // focusNode: context.read<QwertyLayoutProvider>().focusNode,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: verticalSize * 0.03),
                      child: KeyRowWidget(
                        horizontalSize: horizontalSize,
                        verticalSize: verticalSize,
                        rowElements: const [
                          'q',
                          'w',
                          'e',
                          'r',
                          't',
                          'y',
                          'u',
                          'i',
                          'o',
                          'p',
                        ],
                        selectedValue: context
                            .watch<QwertyLayoutProvider>()
                            .selectedString,
                      ),
                    ),
                    KeyRowWidget(
                      horizontalSize: horizontalSize,
                      verticalSize: verticalSize,
                      rowElements: const [
                        'a',
                        's',
                        'd',
                        'f',
                        'g',
                        'h',
                        'j',
                        'k',
                        'l',
                        ';',
                      ],
                      selectedValue:
                          context.watch<QwertyLayoutProvider>().selectedString,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: verticalSize * 0.03),
                      child: KeyRowWidget(
                        horizontalSize: horizontalSize,
                        verticalSize: verticalSize,
                        rowElements: const [
                          'z',
                          'x',
                          'c',
                          'v',
                          'b',
                          'n',
                          'm',
                          ',',
                          '.',
                          '?',
                        ],
                        selectedValue: context
                            .watch<QwertyLayoutProvider>()
                            .selectedString,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //todo: Atras onTap
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: verticalSize * 0.1,
                            width: horizontalSize * 0.22,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius:
                                  BorderRadius.circular(verticalSize * 0.01),
                            ),
                            child: Center(
                              child: Text(
                                'Atras',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: verticalSize * 0.04,
                                  fontWeight: FontWeight.w700,
                                  height: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            //todo: smiley onTap
                            GestureDetector(
                              child: Container(
                                height: verticalSize * 0.1,
                                width: horizontalSize * 0.09,
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(
                                      verticalSize * 0.01),
                                ),
                                child: Icon(
                                  Icons.emoji_emotions_outlined,
                                  size: verticalSize * 0.06,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: horizontalSize * 0.025,
                            ),
                            KeyWidget(
                              text: '123',
                              onTap: () {},
                              selectedValue: 'selectedValue',
                              horizontalSize: horizontalSize,
                              verticalSize: verticalSize,
                            ),
                            SizedBox(
                              width: horizontalSize * 0.025,
                            ),
                            //todo: upArrow onTap
                            GestureDetector(
                              child: Container(
                                height: verticalSize * 0.1,
                                width: horizontalSize * 0.09,
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(
                                      verticalSize * 0.01),
                                ),
                                child: Icon(
                                  Icons.arrow_upward,
                                  size: verticalSize * 0.06,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: horizontalSize * 0.025,
                            ),
                            //todo: arrowForward onTap
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: verticalSize * 0.1,
                                width: horizontalSize * 0.21,
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(
                                      verticalSize * 0.01),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: verticalSize * 0.1,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: horizontalSize * 0.03,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await context
                            .read<QwertyLayoutProvider>()
                            .speakSentenceAndSendItToLearn();
                      },
                      child: Container(
                        height: verticalSize * 0.2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius:
                              BorderRadius.circular(verticalSize * 0.02),
                        ),
                        child: Icon(
                          Icons.volume_up_sharp,
                          color: Colors.white,
                          size: verticalSize * 0.2,
                        ),
                      ),
                    ),

                    /// just a place holder
                    Opacity(
                      opacity: 0,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: verticalSize * 0.03),
                        child: KeyRowWidget(
                          horizontalSize: horizontalSize,
                          verticalSize: verticalSize,
                          rowElements: const [
                            '?',
                          ],
                          selectedValue: 'p',
                        ),
                      ),
                    ),

                    /// first value
                    PredictionWidget(
                      verticalSize: verticalSize,
                      text: context.watch<QwertyLayoutProvider>().hintsValues[0],
                      onTap: () {},
                    ),

                    ///second value
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: verticalSize * 0.03),
                      child: PredictionWidget(
                        verticalSize: verticalSize,
                        text: context.watch<QwertyLayoutProvider>().hintsValues[1],
                        onTap: () {},
                      ),
                    ),

                    ///third value
                    PredictionWidget(
                      verticalSize: verticalSize,
                      text: context.watch<QwertyLayoutProvider>().hintsValues[2],
                      onTap: () {},
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
