import 'package:flutter/material.dart';

class GlibAppBar extends StatelessWidget {
  final Widget? title;
  final bool forceElevated;
  final double? elevation;
  final bool pinned;
  final bool floating;
  final bool snap;
  final Color? backgroundColor;
  final double? expandedHeight;
  final Widget? flexibleSpace;
  final List<Widget>? actions;

  const GlibAppBar({
    this.title,
    this.forceElevated = true,
    this.elevation,
    this.pinned = true,
    this.floating = true,
    this.snap = true,
    this.backgroundColor,
    this.expandedHeight,
    this.flexibleSpace,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: backgroundColor,
      forceElevated: forceElevated,
      elevation: elevation ?? Theme.of(context).appBarTheme.elevation,
      expandedHeight: expandedHeight,
      flexibleSpace: flexibleSpace,
      pinned: pinned,
      floating: floating,
      snap: snap,
      title: title,
      actions: actions,
    );
  }
}
