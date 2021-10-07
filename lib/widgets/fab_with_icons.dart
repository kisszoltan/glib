import 'package:flutter/material.dart';
import 'package:glib/widgets/anchored_overlay.dart';

// https://stackoverflow.com/questions/46480221/flutter-floating-action-button-with-speed-dail
class FabWithIcons extends StatefulWidget {
  FabWithIcons({
    required this.icon,
    required this.icons,
    required this.onIconTapped,
  }) : assert(icons.length > 0);

  final IconData icon;
  final List<IconData> icons;
  final ValueChanged<int> onIconTapped;

  @override
  State createState() => FabWithIconsState();
}

class FabWithIconsState extends State<FabWithIcons>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.icons.length == 1) {
      return FloatingActionButton(
        onPressed: () => widget.onIconTapped(0),
        child: Icon(widget.icons[0]),
        elevation: 2.0,
      );
    }
    var expandedWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children:
          List.generate(widget.icons.length, (int index) => _buildChild(index))
              .toList()
            ..add(_buildFab()),
    );
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        // see also FloatingActionButton._kMiniSizeConstraints + padding
        double _kMiniSizeConstraints = 48;
        return CenterAbout(
          position: Offset(offset.dx,
              offset.dy - widget.icons.length * _kMiniSizeConstraints / 2),
          child: expandedWidget,
        );
      },
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }

  Widget _buildChild(int index) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0 - index / widget.icons.length / 2.0,
            curve: Curves.easeOut),
      ),
      child: FloatingActionButton(
        backgroundColor: backgroundColor,
        mini: true,
        child: Icon(widget.icons[index], color: foregroundColor),
        onPressed: () => _onTapped(index),
      ),
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      onPressed: () {
        if (_controller.isDismissed) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      child: Icon(widget.icon),
      elevation: 2.0,
    );
  }

  void _onTapped(int index) {
    _controller.reverse();
    widget.onIconTapped(index);
  }
}

class FABAction {
  final IconData icon;
  final void Function(BuildContext) onCall;

  FABAction({required this.icon, required this.onCall});
}
