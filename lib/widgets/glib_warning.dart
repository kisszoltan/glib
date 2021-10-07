import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlibWarning extends StatelessWidget {
  const GlibWarning({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).hintColor;
    var foregroundColor = Theme.of(context).colorScheme.onError;
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          // fit: FlexFit.tight,
          child: Container(
            color: backgroundColor,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.exclamationmark_triangle,
                    color: foregroundColor,
                    size: 32,
                  ),
                ),
                Expanded(
                  child: Text(
                    text,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: foregroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
