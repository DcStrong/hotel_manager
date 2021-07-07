import 'package:flutter/material.dart';
import 'package:hotel_manager/components/tab_navigator/tab_item.dart';
import 'package:hotel_manager/components/tab_navigator/tab_navigator.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/provider/basket_product.dart';
import 'package:provider/provider.dart';

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
      icon: Container(
        width: 60,
        height: 35,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 30,
                color: TabNavigator.currentTab.value == index ? ConfigColor.assentColor : ConfigColor.additionalColor.withOpacity(0.6),
              ),
            ),
            Consumer<Basket>(
              builder: (BuildContext context, store, Widget? child) {
                return 
                index == 0 && store.basketInFood.length != 0 ?
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                        width: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ConfigColor.assentColor,
                        ),
                        child: Center(child: Text(store.basketInFood.length.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)))
                      )
                    ) : SizedBox();
                  }
            ),
          ],
        ),
      ),
      // ignore: deprecated_member_use
      title: SizedBox()
    );
  }

}