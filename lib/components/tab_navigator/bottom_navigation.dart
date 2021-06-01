import 'package:flutter/material.dart';
import 'package:hotel_manager/components/tab_navigator/tab_item.dart';
import 'package:hotel_manager/components/tab_navigator/tab_navigator.dart';
import 'package:hotel_manager/helper/config_color.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({
    required this.onSelectTab,
    required this.tabs,
  });
  final ValueChanged<int> onSelectTab;
  final List<TabItem> tabs;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: tabs.where((e)=>e.bottom).map((e) => _buildItem(
        index: e.index,
        icon: e.icon,
      )).toList(),
      onTap: (index) => onSelectTab(
        index,
      ),
    );
  }

  BottomNavigationBarItem _buildItem({int ?index, IconData ?icon}) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        size: 30,
        color: TabNavigator.currentTab.value == index ? ConfigColor.assentColor : ConfigColor.additionalColor.withOpacity(0.6),
      ),
      // ignore: deprecated_member_use
      title: SizedBox()
    );
  }

}