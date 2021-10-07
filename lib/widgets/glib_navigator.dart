import 'package:flutter/material.dart';

class GlibNavigator<T> extends Navigator {
  GlibNavigator({
    required Map<String, Function> rules,
  })  : assert(rules.isNotEmpty),
        super(
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute<T>(
              settings: settings,
              builder: (BuildContext context) {
                var rule = rules[settings.name];
                if (rule == null) rule = rules[0]; // default case
                return rule!(settings.name);
              },
            );
          },
        );
}
