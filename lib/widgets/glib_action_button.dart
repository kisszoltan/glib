import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlibActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? navigationTarget;
  final Object? navigationArgs;
  final String? text;
  final Icon? icon;

  GlibActionButton({
    this.onPressed,
    this.navigationTarget,
    this.navigationArgs,
    this.text,
    this.icon,
  })  : assert(text == null ? icon != null : true),
        assert(onPressed == null ? navigationTarget != null : true);

  void navigate(BuildContext context) {
    Navigator.pushNamed(context, navigationTarget!, arguments: navigationArgs);
  }

  @override
  Widget build(BuildContext context) {
    if ((text ?? '') != '') {
      return TextButton(
        onPressed: onPressed ?? () => navigate(context),
        child: Text(
          text!,
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
      );
    }
    return IconButton(
      onPressed: onPressed ?? () => navigate(context),
      icon: this.icon!,
    );
  }
}