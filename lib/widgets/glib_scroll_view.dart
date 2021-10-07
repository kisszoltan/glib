import 'package:flutter/material.dart';
import 'package:glib/widgets/glib_search_bar.dart';
import 'package:glib/widgets/glib_types.dart';

class GlibScrollView extends StatelessWidget {
  final List<Widget>? slivers;
  final bool showSearch;
  final RenderFunction? renderSuggestion;

  GlibScrollView({
    this.slivers,
    this.showSearch = false,
    this.renderSuggestion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(children: [
        CustomScrollView(slivers: slivers!),
        Visibility(
          visible: showSearch,
          child: GlibSearchBar(
            renderSuggestion: renderSuggestion,
          ),
        ),
      ]),
    );
  }
}
