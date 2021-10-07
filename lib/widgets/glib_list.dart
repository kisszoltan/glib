import 'package:flutter/material.dart';

class GlibList extends SliverPadding {
  GlibList({
    List<Widget>? children,
  }) : super(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          sliver: SliverList(
            // delegate: SliverChildListDelegate(children!),
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  index < children!.length ? children[index] : null,
            ),
          ),
        );
}
