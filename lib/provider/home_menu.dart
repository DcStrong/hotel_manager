import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hotel_manager/model/menu_item.dart';

class HomeMenuProvider with ChangeNotifier {
  final List<MenuItem> homeMenu = [
    MenuItem(name: 'Акции', icon: 'assets/icons/fitnes.png', path: 'stocks', routePath: 'screenProduct'),
    MenuItem(name: 'Басейны', icon: 'assets/icons/fitnes.png', path: 'pools', routePath: 'screenProduct'),
    MenuItem(name: 'Анимация', icon: 'assets/icons/fitnes.png', active: true, routePath: 'animation'),
    MenuItem(name: 'Мероприятия', icon: 'assets/icons/fitnes.png', path: 'activities', routePath: 'screenProduct'),
    MenuItem(name: 'Экскурсии', icon: 'assets/icons/fitnes.png', path: 'excursions', routePath: 'screenProduct'),
    MenuItem(name: 'Фитнес', icon: 'assets/icons/fitnes.png', path: 'fitnes', routePath: 'screenProduct'),
    MenuItem(name: 'SPA', icon: 'assets/icons/fitnes.png', path: 'spa-procedures', routePath: 'spaCategories'),
  ];
  UnmodifiableListView<MenuItem> get homeMenuList => UnmodifiableListView(homeMenu);

  void activateElementMenu(String path) {
    homeMenuList.forEach((element) {
      if(element.path == path) element.active = true;
    });
    notifyListeners();
  }
}