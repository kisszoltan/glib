import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// HINT: Read more about Material color system
// https://material.io/design/color/the-color-system.html
class GlibTheme {
  ColorScheme? from;

  GlibTheme({this.from});

  // HINT: Use https://material.io/inline-tools/color to generate swatch.
  static const MaterialColor lightTeal = MaterialColor(
    0xFF009191,
    <int, Color>{
      50: Color(0xFFe0f1f3),
      100: Color(0xFFb2dddf),
      200: Color(0xFF7fc8cb),
      300: Color(0xFF4cb2b5),
      400: Color(0xFF25a1a3),
      500: Color(0xFF009191), // <- primary
      600: Color(0xFF018483),
      700: Color(0xFF037472),
      800: Color(0xFF076462),
      900: Color(0xFF094845),
    },
  );

  static ColorScheme get defaultScheme => ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: lightTeal,
        primaryColorDark: const Color(0xFF006364),
        accentColor: const Color(0xFF009100), // <- secondary
        // backgroundColor: Colors.grey,
        // cardColor: Colors.white,
        errorColor: Colors.red,
      );

  ThemeData get build {
    var scheme = from ?? defaultScheme;
    return ThemeData(
      colorScheme: scheme,
      toggleableActiveColor:
          brightnessColor(scheme, scheme.primary, scheme.secondary),
      unselectedWidgetColor: scheme.brightness == Brightness.light
          ? scheme.background
          : scheme.onBackground,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: scheme.brightness == Brightness.light
            ? scheme.onPrimary
            : scheme.onSurface,
        backgroundColor: scheme.brightness == Brightness.light
            ? scheme.primary
            : scheme.surface,
      ),
    );
  }

  Color brightnessColor(ColorScheme scheme, Color optionA, Color optionB) =>
      scheme.brightness == Brightness.light ? optionA : optionB;
}
