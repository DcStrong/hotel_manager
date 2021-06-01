import 'package:flutter/material.dart';
import 'package:hotel_manager/components/tab_navigator/tab_navigator.dart';
import 'package:hotel_manager/routes.dart';

class TabItem {
  final String label;
  final IconData icon;
  final String root;
  final bool bottom;
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  int _index = 0;
  bool maintainState;

  TabItem({
    required this.label,
    required this.root,
    required this.icon,
    this.maintainState = true,
    this.bottom = true,
  });

  void setIndex(int i) {
    _index = i;
  }

  int get index => _index;

  Widget get page {
    return Visibility(
      visible: _index == TabNavigator.currentTab.value,
      maintainState: maintainState,
      child: Navigator(
        key: key,
        initialRoute: root,
        onGenerateRoute: (routeSettings){
          return RouteGenerator.generateRoute(routeSettings);
        },
      ),
    );
  }
}