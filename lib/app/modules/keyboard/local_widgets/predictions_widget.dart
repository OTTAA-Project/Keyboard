import 'package:flutter/material.dart';
import 'package:keyboard/app/modules/keyboard/local_widgets/local_widgets.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:provider/provider.dart';

class PredictionsWidget extends StatelessWidget {
  const PredictionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutProvider = context.watch<KeyboardLayoutProvider>();
    return Column(
      children: layoutProvider.hintsValues
          .map((hint) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: PredictionWidget(
                    isCached: hint?.scores == null,
                    text: hint?.name ?? '',
                    onTap: hint?.name?.trim().isEmpty ?? true
                        ? null
                        : () async => context.read<KeyboardLayoutProvider>().addHintToSentence(
                              text: hint!.name!,
                            ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
