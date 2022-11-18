import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard/application/themes/app_theme.dart';

class ButtonWidget extends StatefulWidget {
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
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..repeat(reverse: true);

  late final Animation<double> _boundingAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AnimatedBuilder(
        animation: _boundingAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: widget.borderColor != null ? Border.all(color: widget.borderColor!.withOpacity(_boundingAnimation.value), width: widget.borderWidth) : null,
            ),
            child: child,
          );
        },
        child: Material(
          type: MaterialType.button,
          color: widget.color ?? const Color(0xff1E1E1E),
          borderOnForeground: true,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            highlightColor: widget.highlightColor ?? kPrimaryMaterialColor.shade100,
            splashColor: widget.splashColor ?? Colors.white,
            onTap: widget.onTap != null
                ? () {
                    HapticFeedback.heavyImpact();
                    widget.onTap?.call();
                  }
                : null,
            child: Center(child: widget.child),
          ),
        ),
      ),
    );
  }
}
