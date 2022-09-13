import 'package:flutter/material.dart';
import 'package:keyboard/app/modules/keyboard/local_widgets/local_widgets.dart';
import 'package:keyboard/app/themes/app_theme.dart';

class KeyWidget extends StatelessWidget {
  const KeyWidget({
    Key? key,
    required this.text,
    required this.onTap,
    required this.selectedValue,
    required this.isFirst,
  }) : super(key: key);
  final String text, selectedValue;
  final bool isFirst;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: isFirst ? EdgeInsets.zero : const EdgeInsets.only(left: 10),
      child: ButtonWidget(
        color: selectedValue == text ? Colors.white : const Color(0xff1E1E1E),
        highlightColor: kPrimaryMaterialColor.shade100,
        splashColor: Colors.white,
        onTap: onTap!,
        child: Text(
          text,
          textScaleFactor: 1 + (1 / size.aspectRatio),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedValue == text ? const Color(0xff1E1E1E) : Colors.white54,
          ),
        ),
      ),
    );
  }
}
