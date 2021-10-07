import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlibListTile extends StatelessWidget {
  final String titleText;
  final String? subtitleText;
  final Widget? subtitle;
  final GestureTapCallback? onTap;
  final Widget? leading;

  GlibListTile({
    Key? key,
    required this.titleText,
    this.subtitleText,
    this.subtitle,
    this.onTap,
    this.leading,
  }) : assert(subtitle != null ? subtitleText == null : true);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      contentPadding: const EdgeInsets.all(0.0),
      title: Text(titleText),
      subtitle: subtitle ?? (subtitleText == null ? null : Text(subtitleText!)),
      leading: leading,
      trailing: Icon(CupertinoIcons.right_chevron),
      onTap: onTap,
    );
  }
}
