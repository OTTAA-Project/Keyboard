import 'package:flutter/material.dart';

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
        // width: horizontalSize * 0.09,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(verticalSize * 0.02),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: verticalSize * 0.04,
              fontWeight: FontWeight.w700,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
