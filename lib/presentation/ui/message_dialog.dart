import 'package:flutter/material.dart';
import 'package:keyboard/presentation/common/ui/animated_dialog.dart';

class MessageDialog extends StatelessWidget {
  final String title;
  final String message;

  const MessageDialog({super.key, required this.title, required this.message});

  static Future<T?> show<T>(BuildContext context, String title, String message) {
    return AnimatedDialog.animate(
      context,
      MessageDialog(title: title, message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: theme.headline5!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SelectableText(
            message,
            textAlign: TextAlign.center,
            style: theme.subtitle2!.copyWith(fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
