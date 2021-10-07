import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glib/widgets/destination_view.dart';
import 'package:glib/screens/glib_screen.dart';
import 'package:provider/provider.dart';

class GlibRootApp extends StatelessWidget {
  final List<GlibScreen> screens;
  final List<Widget> Function(BuildContext)? drawerLinksBuilder;
  final ThemeData? theme;

  GlibRootApp({required this.screens, this.theme, this.drawerLinksBuilder});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedScreen(screens)),
        Provider(create: (_) => screens),
      ],
      child: MaterialApp(
        home: HomePage(drawerLinksBuilder),
        title: 'Glib Demo',
        theme: theme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [const Locale('hu')],
        locale: Locale('hu'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<Widget> Function(BuildContext)? drawerLinksBuilder;
  HomePage(this.drawerLinksBuilder);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    var _screens = context.watch<List<GlibScreen>>();
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: context.watch<SelectedScreen>().index,
          children: authorized(_screens).map<Widget>((GlibScreen screen) {
            return DestinationView(destination: screen);
          }).toList(),
        ),
      ),
      drawer: widget.drawerLinksBuilder == null
          ? null
          : Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text(
                      '<Application Name>',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ),
                  ...widget.drawerLinksBuilder!(context),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 2.0,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: (_screens.length >= 2)
          ? FABBottomAppBar(
              currentIndex: context.watch<SelectedScreen>().index,
              onTabSelected: (int index) {
                setState(() {
                  var _screenName = authorized(_screens)[index].name;
                  context.read<SelectedScreen>().selectByName(_screenName);
                });
              },
              items: authorized(_screens).map((GlibScreen screen) {
                return FABBottomAppBarItem(
                  iconData: screen.icon,
                  text: screen.caption,
                );
              }).toList(),
            )
          : null,
    );
  }
}

class FABBottomAppBarItem {
  FABBottomAppBarItem({required this.iconData, required this.text});
  IconData iconData;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    required this.currentIndex,
    required this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape: const CircularNotchedRectangle(),
    required this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final int currentIndex;
  final List<FABBottomAppBarItem> items;
  final String? centerItemText;
  final double height;
  final double iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  _updateIndex(int index) {
    widget.onTabSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    var theme = Theme.of(context);
    var selectedColor = widget.selectedColor ?? theme.primaryColor;
    var unselectedColor = widget.color ?? theme.unselectedWidgetColor;

    Color? color =
        widget.currentIndex == index ? selectedColor : unselectedColor;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: widget.iconSize),
                Text(
                  item.text,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectedScreen with ChangeNotifier, DiagnosticableTreeMixin {
  late String _currentScreen;
  List<GlibScreen> _screens;
  SelectedScreen(this._screens) {
    _currentScreen = _screens[0].name;
  }

  int get index => indexByName(_currentScreen);

  int indexByName(String screenName) {
    return authorized(_screens)
        .indexWhere((element) => element.name == screenName);
  }

  void selectByName(String screenName) {
    _currentScreen = authorized(_screens)[indexByName(screenName)].name;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('index', indexByName(_currentScreen)));
  }
}

List<GlibScreen> authorized(List<GlibScreen> _screens) {
  List<GlibScreen> ret = [];
  ret.addAll(_screens.where((element) => true));
  return ret;
}
