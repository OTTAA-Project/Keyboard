import 'package:flutter/material.dart';
import 'package:keyboards/app/providers/keyboard_layout_provider.dart';
import 'package:keyboards/app/utils/constants.dart';
import 'package:provider/provider.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.controller,
    // required this.focusNode,
  }) : super(key: key);

  final double height, width;
  final TextEditingController controller;
  // final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.02),
        color: kButtonColor,
      ),
      child: Stack(
        children: [
          TextFormField(
            // focusNode: focusNode,
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            cursorColor: Colors.white,
            style: const TextStyle(
              color: Colors.white,
            ),
            maxLines: 2,
            enabled: false,
          ),
          //todo: add the callbacks for the functions
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconWidget(
                  height: height,
                  onTap: () async {
                    await context.read<KeyboardLayoutProvider>().addSpace();
                  },
                  iconData: Icons.space_bar_outlined,
                ),
                IconWidget(
                  height: height,
                  onTap: () {
                    context.read<KeyboardLayoutProvider>().deleteLastCharacter();
                  },
                  iconData: Icons.backspace_outlined,
                ),
                IconWidget(
                  height: height,
                  onTap: () async {
                    await context.read<KeyboardLayoutProvider>().deleteWholeSentence();
                  },
                  iconData: Icons.delete,
                ),
                IconWidget(
                  onTap: () {},
                  height: height,
                  iconData: Icons.arrow_back_ios_outlined,
                ),
                IconWidget(
                  height: height,
                  onTap: () {},
                  iconData: Icons.arrow_forward_ios_outlined,
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
    required this.height,
    required this.onTap,
    required this.iconData,
  }) : super(key: key);
  final double height;
  final void Function()? onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      splashRadius: 1,
      icon: Icon(
        iconData,
        size: height * 0.04,
        color: Colors.white,
      ),
    );
  }
}
