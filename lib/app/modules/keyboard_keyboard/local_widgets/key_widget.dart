import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboards/app/themes/app_theme.dart';

class KeyWidget extends StatelessWidget {
  const KeyWidget({
    Key? key,
    required this.text,
    required this.onTap,
    required this.selectedValue,
    required this.height,
    required this.width,
  }) : super(key: key);
  final String text, selectedValue;
  final void Function()? onTap;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: height,
        width: width,
        child: Material(
          type: MaterialType.button,
          color: selectedValue == text ? Colors.white : const Color(0xff1E1E1E),
          child: InkWell(
            highlightColor: kPrimaryMaterialColor.shade100,
            splashColor: Colors.white,
            onTap: () {
              HapticFeedback.heavyImpact();
              onTap!();
            },
            onLongPress: () {
              // if (widget.enableLongPressUppercase && !widget.enableAllUppercase) {
              //   widget.controller?.text += letter.toUpperCase();
              //   widget.controller?.selection = TextSelection.fromPosition(TextPosition(offset: widget.controller!.text.length));
              // }
            },
            child: Center(
              child: Text(
                text,
                textScaleFactor: 1 + (1 / height),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedValue == text ? const Color(0xff1E1E1E) : Colors.white54,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
