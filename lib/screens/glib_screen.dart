import 'package:flutter/widgets.dart';

abstract class GlibScreen extends StatefulWidget {
  const GlibScreen(
      {Key? key,
        required this.caption,
        required this.name,
        required this.icon})
      : super(key: key);

  final String caption;
  final String name;
  final IconData icon;
}