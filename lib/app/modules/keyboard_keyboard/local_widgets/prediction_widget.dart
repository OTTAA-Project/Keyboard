import 'package:flutter/material.dart';
import 'package:keyboard/app/utils/constants.dart';

class PredictionWidget extends StatelessWidget {
  const PredictionWidget({
    Key? key,
    required this.verticalSize,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final double verticalSize;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: verticalSize * 0.1,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kButtonColor,
          borderRadius: BorderRadius.circular(verticalSize * 0.02),
        ),
        child: Center(
          child: Text(
            text,
            textScaleFactor: 1 + (1 / verticalSize),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
