import 'package:flutter/material.dart';
import 'package:glib/screens/glib_screen.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({Key? key, this.destination}) : super(key: key);

  final GlibScreen? destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return widget.destination!;
  }
}

