import 'package:flutter/material.dart';

class KeyWidget extends StatelessWidget {
  const KeyWidget({
    Key? key,
    required this.text,
    required this.onTap,
    required this.selectedValue,
    required this.horizontalSize,
    required this.verticalSize,
  }) : super(key: key);
  final String text, selectedValue;
  final void Function()? onTap;
  final double verticalSize, horizontalSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.symmetric(
        //   vertical: verticalSize * 0.025,
        //   horizontal: horizontalSize * 0.03,
        // ),
        height: verticalSize * 0.1,
        width: horizontalSize * 0.05,
        decoration: BoxDecoration(
          color: selectedValue == text ? Colors.white : Colors.grey[700],
          borderRadius: BorderRadius.circular(verticalSize * 0.01),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: selectedValue == text ? Colors.black : Colors.white,
                fontSize: verticalSize * 0.028,
                fontWeight: FontWeight.w700,
                height: 1.0),
          ),
        ),
      ),
    );
  }
}
