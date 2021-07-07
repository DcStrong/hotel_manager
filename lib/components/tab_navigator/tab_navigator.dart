

// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:hotel_manager/components/tab_navigator/tab_item.dart';

import 'bottom_navigation.dart';

// ignore: must_be_immutable
class TabNavigator extends StatefulWidget with ChangeNotifier{
  TabNavigator({Key ?key}) : super(key: key);
  static bool onGoingCall = false;
  static ValueNotifier<int> currentTab = ValueNotifier<int>(1);
  static changeValue(int i) {
    currentTab.value = i;
    currentTab.notifyListeners();
  }

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  @override
  void initState() {
    super.initState();
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }

  GlobalKey childkey = GlobalKey();

  final List<TabItem> tabs = [
    TabItem(
      label: '-',
      icon: Icons.shopping_basket_outlined,
      maintainState: false,
      root: 'restorant',
    ),
    TabItem(
      label: '-',
      icon: Icons.home_outlined,
      maintainState: true,
      root: 'home',
    ),
    TabItem(
      label: '-',
      icon: Icons.account_circle_outlined,
      maintainState: false,
      root: 'profile',
    ),
  ];

  void selectTab(int index, {Map ?arguments}) {
    if (index != TabNavigator.currentTab.value) {
      TabNavigator.changeValue(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      key: childkey,
      onWillPop: () async {
        NavigatorState navigatorState =
            tabs[TabNavigator.currentTab.value].key.currentState!;
        final isFirstRouteInCurrentTab = navigatorState.canPop();
        if (isFirstRouteInCurrentTab) {
          navigatorState.pop();
        }
        return false;
      },
      child: ValueListenableBuilder(
        valueListenable: TabNavigator.currentTab,
        builder: (context, int value, _) {
          return Scaffold(
            body: IndexedStack(
              index: value,
              children: tabs.map((e) => e.page).toList(),
            ),
            bottomNavigationBar: BottomNavigation(
              onSelectTab: selectTab,
              tabs: tabs,
            ),
          );
        },
      ),

    );
  }
}
