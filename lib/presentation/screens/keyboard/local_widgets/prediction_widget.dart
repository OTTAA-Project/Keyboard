import 'package:flutter/material.dart';
import 'package:keyboard/presentation/screens/keyboard/local_widgets/button.dart';

class PredictionWidget extends StatelessWidget {
  const PredictionWidget({
    Key? key,
    required this.text,
    this.onTap,
    this.isCached = false,
  }) : super(key: key);

  final bool isCached;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ButtonWidget(
      onTap: onTap,
      borderColor: isCached ? Colors.white30 : Colors.transparent,
      borderWidth: isCached ? 4 : 0,
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
