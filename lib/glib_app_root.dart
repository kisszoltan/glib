import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glib/screens/glib_screen.dart';
import 'package:glib/widgets/destination_view.dart';
import 'package:glib/widgets/fab_bottom_app_bar.dart';
import 'package:glib/widgets/fab_with_icons.dart';
import 'package:provider/provider.dart';

var _actions = [
  FABAction(
      icon: Icons.house,
      onCall: (c) {
        print("house");
      }),
  FABAction(
      icon: Icons.add,
      onCall: (c) {
        print("add");
      }),
  FABAction(
      icon: Icons.car_repair,
      onCall: (c) {
        print("car");
      }),
  FABAction(
      icon: Icons.sports_baseball,
      onCall: (c) {
        print("ball");
      }),
];

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
      floatingActionButton: FabWithIcons(
        icon: Icons.add,
        icons: _actions.map((e) => e.icon).toList(),
        onIconTapped: (index) => _actions[index].onCall(context),
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
