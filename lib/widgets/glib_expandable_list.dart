import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Grouped list view
class GlibExpandableList<T> extends StatefulWidget {
  final Map<dynamic, List<T>> map;
  final Widget Function(String, List<T>?)? groupTitle;
  final Widget Function(BuildContext, T)? renderListItem;

  const GlibExpandableList({
    Key? key,
    required this.map,
    this.groupTitle,
    this.renderListItem,
  }) : super(key: key);

  @override
  _GlibExpandableListState<T> createState() => _GlibExpandableListState<T>();
}

class _GlibExpandableListState<T> extends State<GlibExpandableList<T>> {
  late List<ExpansionItem<T>> _data;

  @override
  void initState() {
    super.initState();
    _data = widget.map.keys
        .map((key) => ExpansionItem(header: key, body: widget.map[key]))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => index == 0
            ? ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _data[index].isExpanded = !isExpanded;
                  });
                },
                children: _data.map<ExpansionPanel>((ExpansionItem<T> item) {
                  return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) =>
                        widget.groupTitle == null
                            ? ListTile(title: Text('${item.header}'))
                            : widget.groupTitle!(item.header, item.body),
                    body: item.body == null
                        ? Container()
                        : Column(
                            children: item.body!
                                .map((e) => widget.renderListItem!(context, e))
                                .toList(),
                          ),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              )
            : null,
      ),
    );
  }
}

class ExpansionItem<T> {
  ExpansionItem({required this.header, this.body});
  bool isExpanded = false;
  final dynamic header;
  final List<T>? body;
}
