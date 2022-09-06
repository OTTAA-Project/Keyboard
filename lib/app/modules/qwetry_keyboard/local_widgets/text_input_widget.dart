import 'package:flutter/material.dart';
import 'package:keyboard/app/providers/qwerty_layout_provider.dart';
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
      padding: EdgeInsets.symmetric(horizontal: width * 0.01),
      height: height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.02),
        color: Colors.grey[700],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            // focusNode: focusNode,
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            cursorColor: Colors.white,
            style: TextStyle(
              fontSize: height * 0.023,
              color: Colors.white,
            ),
            maxLines: 2,
            enabled: false,
          ),
          //todo: add the callbacks for the functions
          Padding(
            padding: EdgeInsets.only(bottom: height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconWidget(
                  height: height,
                  onTap: ()async{
                    await context.read<QwertyLayoutProvider>().addSpace();
                  },
                  iconData: Icons.space_bar_outlined,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: IconWidget(
                    height: height,
                    onTap: () {
                      context.read<QwertyLayoutProvider>().deleteLastCharacter();
                    },
                    iconData: Icons.backspace_outlined,
                  ),
                ),
                IconWidget(
                  height: height,
                  onTap: () async{
                    await context.read<QwertyLayoutProvider>().deleteWholeSentence();
                  },
                  iconData: Icons.delete,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: IconWidget(
                    onTap: () {},
                    height: height,
                    iconData: Icons.arrow_back_ios_outlined,
                  ),
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
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        iconData,
        size: height * 0.05,
        color: Colors.white,
      ),
    );
  }
}
