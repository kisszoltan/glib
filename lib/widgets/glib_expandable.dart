import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Expandable text component with title
class GlibExpandable extends StatelessWidget {
  const GlibExpandable({Key? key, required this.title, required this.details})
      : super(key: key);
  final String title;
  final String details;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ExpandableTheme(
        data: ExpandableThemeData(
          hasIcon: false,
          tapBodyToCollapse: true,
          tapBodyToExpand: true,
        ),
        child: ExpandablePanel(
            header: Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
            collapsed: Text(
              details,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
            expanded: Text(
              details,
              softWrap: true,
              textAlign: TextAlign.justify,
            )),
      ),
    );
  }
}
