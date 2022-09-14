import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard/app/themes/app_theme.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.color,
    this.splashColor,
    this.highlightColor,
    this.borderColor,
    this.borderWidth = 0,
  }) : super(key: key);
  final Widget child;
  final Function? onTap;
  final Color? color, splashColor, highlightColor, borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: borderColor != null ? Border.all(color: borderColor!, width: borderWidth) : null,
        ),
        child: Material(
          type: MaterialType.button,
          color: color ?? const Color(0xff1E1E1E),
          borderOnForeground: true,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            highlightColor: highlightColor ?? kPrimaryMaterialColor.shade100,
            splashColor: splashColor ?? Colors.white,
            onTap: onTap != null
                ? () {
                    HapticFeedback.heavyImpact();
                    onTap?.call();
                  }
                : null,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
