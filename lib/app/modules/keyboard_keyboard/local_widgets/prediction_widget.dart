import 'package:flutter/material.dart';
import 'package:keyboard/app/modules/keyboard_keyboard/local_widgets/button.dart';
import 'package:keyboard/app/utils/constants.dart';

class PredictionWidget extends StatelessWidget {
  const PredictionWidget({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ButtonWidget(
      onTap: onTap,
      child: Text(
        text,
        textScaleFactor: 1 + (1 / size.height),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          height: 1.0,
        ),
      ),
    );
  }
}
