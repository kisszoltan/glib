import 'package:flutter/material.dart';
import 'package:glib/widgets/glib_expandable.dart';

class GlibTitle extends StatelessWidget {
  const GlibTitle({
    Key? key,
    required this.title,
    required this.details,
  }) : super(key: key);

  final String title;
  final dynamic details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [detailsWidget(context, details)],
      ),
    );
  }

  Widget detailsWidget(BuildContext context, dynamic details) {
    switch (details.runtimeType) {
      case String:
        return GlibExpandable(
          title: title,
          details: details,
        );
      case bool:
        return Checkbox(
          value: details as bool,
          onChanged: (context) {},
        );
      default:
        return details;
    }
  }
}

