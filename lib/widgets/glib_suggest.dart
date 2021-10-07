import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glib/models/glib_search_model.dart';
import 'package:provider/provider.dart';

class GlibSuggest extends StatelessWidget {
  final Widget? child;
  final GestureTapCallback? onTap;
  final String? navigationTarget;
  final dynamic navigationArg;
  final Icon? leading;
  const GlibSuggest({
    Key? key,
    this.onTap,
    this.navigationTarget,
    this.navigationArg,
    this.child,
    this.leading,
  })  : assert(onTap != null || navigationTarget != null),
        assert(navigationTarget != null ? navigationArg != null : true),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Consumer<GlibSearchModel>(
            builder: (BuildContext context, model, Widget? child) {
              return GestureDetector(
                onTap: () {
                  if (navigationTarget != null) {
                    Navigator.pushNamed(
                      context,
                      navigationTarget!,
                      arguments: navigationArg,
                    );
                    model.saveAndClose();
                  } else {
                    this.onTap!();
                  }
                },
                child: ListTile(
                  leading: this.leading,
                  title: this.child,
                ),
              );
            },
          ),
          // Divider(),
        ],
      ),
    );
  }
}
