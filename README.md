# Introduction

Glib is Rapid Development Framework for Flutter inspired by GlideApps|https://www.glideapps.com.

The package gives you:
 - navigation
 - list screen
 - details screen
 - edit screen

Copyright 2021 Zoltan Kiss. Licensed under BSD 3-Clause License.

## Getting Started
In `pubspec.yaml`, add:
```yaml
  dependencies:
    glib: any
```

In your `main.dart` add the following content:
```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glib/glib.dart';

void main() {
  runApp(GlibRootApp(
    screens: <GlibScreen>[
      HelloScreen(),
    ],
  ));
}

class HelloScreen extends GlibScreen {
  const HelloScreen({Key? key})
      : super(
          key: key,
          caption: 'Hello',
          name: 'hello',
          icon: CupertinoIcons.house,
        );

  @override
  State<StatefulWidget> createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {
  @override
  Widget build(BuildContext context) {
    return GlibNavigator(
      rules: {
        '/': (name) => HelloPage(),
      },
    );
  }
}

class HelloPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlibScrollView(
      slivers: [
        GlibAppBar(
          title: Text('Hello'),
        ),
        GlibList(
          children: [
            Center(child: Text('Hello World!')),
          ],
        ),
      ],
    );
  }
}
```

Having all the above you will have a Flutter application with one screen, showing "Hello World!" 
text in the middle. In the background the application have a navigation logic setup, where each 
"screen" is a tab, selected by the bottom navigation, and every screen can have different sub-pages 
to navigate to. The navigation holds it state per pages, so navigating between different tabs will 
keep the navigation state of sub-pages.