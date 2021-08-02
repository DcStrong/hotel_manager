import 'package:flutter/material.dart';
import 'package:hotel_manager/components/widget/icons_button.dart';
import 'package:hotel_manager/model/menu_item.dart';
import 'package:hotel_manager/provider/home_menu.dart';
import 'package:provider/provider.dart';

class HomeMenu extends StatelessWidget {
  HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> _menuItem = context.watch<HomeMenuProvider>().homeMenuList;
    return
    _menuItem.length == 0 ?
    Container()
    :
    Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      height: 100,
      child: ListView.separated(
        separatorBuilder: (ctx, i) {
          return _menuItem[i].active ? SizedBox(width: 12,) : Container();
        },
        scrollDirection: Axis.horizontal,
        itemCount: _menuItem.length,
        itemBuilder: (ctx, i) {
          return _menuItem[i].active 
          ?
          Container(
            width: 80,
            child: NeomorfIconButton(icons: _menuItem[i].icon!, text: _menuItem[i].name!, path: _menuItem[i].path ?? '', routePath: _menuItem[i].routePath ?? '',)) 
          :
          Container();
        }
      ),
    );
  }
}