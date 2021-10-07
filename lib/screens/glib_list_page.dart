import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glib/models/glib_search_model.dart';
import 'package:glib/widgets/glib_app_bar.dart';
import 'package:glib/widgets/glib_expandable_list.dart';
import 'package:glib/widgets/glib_list.dart';
import 'package:glib/widgets/glib_scroll_view.dart';
import 'package:glib/widgets/glib_suggest.dart';
import 'package:glib/widgets/glib_types.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class GlibListPage<T> extends StatefulWidget {
  final List<T> items;
  final dynamic Function(T)? groupByKey;
  final Widget Function(String, List<T>?)? groupTitle;
  final GlibSearchModel? searchModel;
  final Widget? title;

  /// Navigation target name to call when clicked on a search result.
  final String? detailsTarget;

  /// Function to call when the item is shown in list.
  final Widget Function(BuildContext, T)? renderListItem;

  /// Function to call when the item is shown as a search result.
  final RenderFunction? renderSuggestItem;

  GlibListPage(
      {Key? key,
      required this.items,
      this.groupByKey,
      this.groupTitle,
      this.searchModel,
      this.detailsTarget,
      this.renderListItem,
      this.renderSuggestItem,
      this.title})
      : assert(searchModel != null ? renderSuggestItem != null : true),
        assert(groupTitle != null ? groupByKey != null : true),
        super(key: key);

  @override
  State<GlibListPage<T>> createState() => _GlibListPageState<T>();
}

class _GlibListPageState<T> extends State<GlibListPage<T>> {
  @override
  Widget build(BuildContext context) {
    var scrollView = GlibScrollView(
      showSearch: widget.searchModel != null,
      renderSuggestion: (widget.renderSuggestItem == null)
          ? null
          : (item) {
              return GlibSuggest(
                navigationTarget: widget.detailsTarget,
                navigationArg: item as T,
                child: widget.renderSuggestItem!(item),
              );
            },
      slivers: [
        GlibAppBar(
          elevation: 0,
          title: widget.title,
          backgroundColor: widget.title == null
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).appBarTheme.backgroundColor,
        ),
        widget.groupByKey == null
            ? GlibList(
                children: this
                    .widget
                    .items
                    .map((i) => widget.renderListItem!(context, i))
                    .toList(),
              )
            : GlibExpandableList<T>(
                map: groupBy(this.widget.items, widget.groupByKey!),
                groupTitle: widget.groupTitle,
                renderListItem: widget.renderListItem,
              ),
      ],
    );
    return widget.searchModel == null
        ? scrollView
        : ChangeNotifierProvider<GlibSearchModel>(
            create: (_) => widget.searchModel!,
            child: scrollView,
          );
  }
}
