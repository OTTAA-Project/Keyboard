import 'package:flutter/material.dart';
import 'package:keyboard/app/modules/keyboard/local_widgets/local_widgets.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class SpeakingIcon extends StatefulWidget {
  const SpeakingIcon({super.key});

  @override
  State<SpeakingIcon> createState() => _SpeakingIconState();
}

class _SpeakingIconState extends State<SpeakingIcon> {
  SMITrigger? _speakTrigger;

  void onInit(Artboard board) {
    try {
      final controller = StateMachineController.fromArtboard(board, 'main');
      board.addController(controller!);
      _speakTrigger = controller.findInput<bool>('speak') as SMITrigger?;
      _speakTrigger?.fire();
    } catch (_) {
      debugPrintStack();
    }
  }

  @override
  Widget build(BuildContext context) {
    final layoutProvider = context.watch<KeyboardLayoutProvider>();

    return ButtonWidget(
      onTap: () async {
        if (layoutProvider.qwertyController.text.isNotEmpty) {
          _speakTrigger?.fire();
          await layoutProvider.speakSentenceAndSendItToLearn();
          _speakTrigger?.fire();
        }
      },
      child: Center(
        child: RiveAnimation.asset(
          "assets/rive/speaker.riv",
          onInit: onInit,
          animations: const ['idle'],
          artboard: "artboard",
        ),
      ),
    );
  }
}
