import 'package:flutter/material.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:keyboard/app/providers/settings_provider.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:provider/provider.dart';

const sizeMultiplierMap = {
  "0": 12.0,
  "0.5": 24.0,
  "1": 54.0,
};

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.controller,
  }) : super(key: key);

  final double height, width;
  final TextEditingController controller;

  double iconSizeMultiplier(double index) => sizeMultiplierMap[index.toString()] ?? 24;

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: width,
      height: height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kButtonColor,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: TextFormField(
              // focusNode: focusNode,
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              maxLines: 2,
              readOnly: true,
            ),
          ),
          //todo: add the callbacks for the functions
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconWidget(
                  onTap: () async {
                    await context.read<KeyboardLayoutProvider>().addSpace();
                  },
                  iconData: Icons.space_bar_outlined,
                  iconSize: iconSizeMultiplier(settingsProvider.buttonActionsSize),
                ),
                const SizedBox(width: 10),
                IconWidget(
                  onTap: () {
                    context.read<KeyboardLayoutProvider>().deleteLastCharacter();
                  },
                  iconData: Icons.backspace_outlined,
                  iconSize: iconSizeMultiplier(settingsProvider.buttonActionsSize),
                ),
                const SizedBox(width: 10),
                IconWidget(
                  onTap: () async {
                    await context.read<KeyboardLayoutProvider>().deleteWholeSentence();
                  },
                  iconSize: iconSizeMultiplier(settingsProvider.buttonActionsSize),
                  iconData: Icons.delete,
                ),
                const SizedBox(width: 10),
                IconWidget(
                  onTap: () {},
                  iconData: Icons.arrow_back_ios_outlined,
                  iconSize: iconSizeMultiplier(settingsProvider.buttonActionsSize),
                ),
                const SizedBox(width: 10),
                IconWidget(
                  onTap: () {},
                  iconData: Icons.arrow_forward_ios_outlined,
                  iconSize: iconSizeMultiplier(settingsProvider.buttonActionsSize),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    required this.onTap,
    required this.iconData,
    required this.iconSize,
  }) : super(key: key);
  final void Function()? onTap;
  final IconData iconData;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      splashRadius: 1,
      iconSize: iconSize,
      icon: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}
