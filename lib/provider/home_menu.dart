import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hotel_manager/model/menu_item.dart';

class HomeMenuProvider with ChangeNotifier {
  final List<MenuItem> homeMenu = [
    MenuItem(name: 'Акции', icon: 'assets/icons/fitnes.png', active: false, path: 'stocks', routePath: 'screenProduct'),
    MenuItem(name: 'SPA', icon: 'assets/icons/Spa.png', active: false, path: 'spa-procedures', routePath: 'spaCategories'),
    MenuItem(name: 'Анимация', icon: 'assets/icons/animations.png', active: true, routePath: 'animation'),
    MenuItem(name: 'Мероприятия', icon: 'assets/icons/Group.png', active: false, path: 'activities', routePath: 'screenProduct'),
    MenuItem(name: 'Фитнес', icon: 'assets/icons/fitnes.png', active: false, path: 'fitnes', routePath: 'screenProduct'),
    MenuItem(name: 'Басейны', icon: 'assets/icons/pools.png', active: false, path: 'pools', routePath: 'screenProduct'),
    MenuItem(name: 'Экскурсии', icon: 'assets/icons/excursions.png', active: false, path: 'excursions', routePath: 'screenProduct'),
  ];
  UnmodifiableListView<MenuItem> get homeMenuList => UnmodifiableListView(homeMenu);

  void activateElementMenu(String path) {
    homeMenuList.forEach((element) {
      if(element.path == path) element.active = true;
    });
    notifyListeners();
  }
}