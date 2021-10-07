import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glib/models/glib_edit_model.dart';
import 'package:glib/widgets/glib_action_button.dart';
import 'package:glib/widgets/glib_app_bar.dart';
import 'package:glib/widgets/glib_list.dart';
import 'package:glib/widgets/glib_scroll_view.dart';
import 'package:provider/provider.dart';

typedef RenderChildren = List<Widget> Function(dynamic item);

class GlibEditPage<T extends ChangeNotifier> extends StatefulWidget {
  final RenderChildren renderChildren;
  GlibEditPage({required this.renderChildren});

  @override
  _GlibEditPageState<T> createState() => _GlibEditPageState<T>();
}

class _GlibEditPageState<T extends ChangeNotifier>
    extends State<GlibEditPage<T>> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as T;

    return Form(
      key: _formKey,
      child: Consumer<GlibEditModel<T>>(
        builder: (context, model, child) {
          model.draft = item;
          return GlibScrollView(
            slivers: [
              GlibAppBar(
                title: Text('Edit'),
                actions: [
                  GlibActionButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        model.save();
                        Navigator.pop(context, model.complete);
                      }
                    },
                    text: 'done',
                  ),
                ],
              ),
              GlibList(
                children: widget.renderChildren(model.draft),
              ),
            ],
          );
        },
      ),
    );
  }
}
