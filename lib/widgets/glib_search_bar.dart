import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glib/models/glib_search_model.dart';
import 'package:glib/widgets/glib_suggest.dart';
import 'package:glib/widgets/glib_types.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class GlibSearchBar extends StatefulWidget {
  final RenderFunction? renderSuggestion;

  const GlibSearchBar({
    Key? key,
    this.renderSuggestion,
  }) : super(key: key);

  @override
  _GlibSearchBarState createState() => _GlibSearchBarState();
}

class _GlibSearchBarState extends State<GlibSearchBar> {
  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlibSearchModel>(
      builder: (context, model, _) {
        model.controller = controller;
        return FloatingSearchBar(
          controller: controller,
          progress: model.isLoading,
          actions: [],
          onQueryChanged: model.onQueryChanged,
          builder: (BuildContext context, Animation<double> transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: model.suggestions.reversed.map((suggest) {
                    if (suggest is String) {
                      return GlibSuggest(
                        leading: const Icon(Icons.history),
                        onTap: () => controller.query = suggest,
                        child: Text(suggest),
                      );
                    }
                    if (widget.renderSuggestion == null) {
                      return GlibSuggest(child: Text(suggest.toString()));
                    }
                    return widget.renderSuggestion!(suggest);
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
