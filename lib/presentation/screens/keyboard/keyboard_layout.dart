import 'package:flutter/material.dart';
import 'package:keyboard/application/common/constants.dart';
import 'package:keyboard/core/enums/keyboard_layouts.dart';
import 'package:keyboard/presentation/screens/keyboard/local_widgets/local_widgets.dart';
import 'package:keyboard/presentation/screens/keyboard/local_widgets/predictions_widget.dart';
import 'package:keyboard/presentation/screens/keyboard/local_widgets/speaking_icon.dart';
import 'package:keyboard/presentation/screens/keyboard_layouts/emojis_layout.dart';
import 'package:keyboard/presentation/screens/keyboard_layouts/numbers_layout.dart';
import 'package:keyboard/presentation/screens/keyboard_layouts/qwerty_layout.dart';
import 'package:keyboard/application/providers/keyboard_layout_provider.dart';
import 'package:keyboard/application/themes/app_theme.dart';
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
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: true,
      backgroundColor: kPrimaryBG,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: size.width,
          height: size.height - kToolbarHeight - 34,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: horizontalSize,
                        child: TextInputWidget(
                          controller: context.watch<KeyboardLayoutProvider>().qwertyController,
                          height: verticalSize,
                          width: horizontalSize,
                          // focusNode: context.read<QwertyLayoutProvider>().focusNode,
                        ),
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
                            const Expanded(
                              flex: 2,
                              child: ButtonWidget(
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
                            const SizedBox(
                              width: 10,
                            ),
                            // space button
                            Expanded(
                              flex: 5,
                              child: ButtonWidget(
                                onTap: () async => await context.read<KeyboardLayoutProvider>().addSpace(),
                                child: const SizedBox(),
                              ),
                            ),

                            //todo: smiley onTap
                            if (context.read<KeyboardLayoutProvider>().currentLayout != KeyboardTypes.emojis) ...[
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ButtonWidget(
                                  onTap: () {
                                    context.read<KeyboardLayoutProvider>().onChangeKeyboardLayout(KeyboardTypes.emojis);
                                  },
                                  child: Icon(
                                    Icons.emoji_emotions_outlined,
                                    size: verticalSize * 0.06,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(
                              width: 10,
                            ),

                            //todo: qwerty onTap
                            if (context.read<KeyboardLayoutProvider>().currentLayout != KeyboardTypes.qwerty) ...[
                              Expanded(
                                child: ButtonWidget(
                                  onTap: () {
                                    context.read<KeyboardLayoutProvider>().onChangeKeyboardLayout(KeyboardTypes.qwerty);
                                  },
                                  child: Icon(
                                    Icons.abc,
                                    size: verticalSize * 0.06,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],

                            //!todo: numbers onTap

                            if (context.read<KeyboardLayoutProvider>().currentLayout != KeyboardTypes.numbers) ...[
                              Expanded(
                                child: ButtonWidget(
                                  onTap: () async {
                                    context.read<KeyboardLayoutProvider>().onChangeKeyboardLayout(KeyboardTypes.numbers);
                                  },
                                  child: const Text(
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
                              const SizedBox(
                                width: 10,
                              ),
                            ],

                            //todo: upArrow onTap
                            Expanded(
                              child: ButtonWidget(
                                child: Icon(
                                  Icons.arrow_upward,
                                  size: verticalSize * 0.06,
                                  color: Colors.white,
                                ),
                                onTap: () => {},
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            //todo: arrowForward onTap
                            Expanded(
                              flex: 2,
                              child: ButtonWidget(
                                onTap: () async => context.read<KeyboardLayoutProvider>().updateHints(),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: verticalSize * 0.08,
                                  color: Colors.white,
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
                                  .models
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                  .toList()
                              : [],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: (verticalSize * 0.2),
                        ),
                        child: const SpeakingIcon(),
                      ),
                      const SizedBox(height: 20),
                      const Expanded(child: PredictionsWidget()),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
