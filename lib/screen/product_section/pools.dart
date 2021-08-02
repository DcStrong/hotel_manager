import 'package:flutter/material.dart';
import 'package:hotel_manager/components/shimmer/horizontal_shimmer.dart';
import 'package:hotel_manager/components/widget/card/horizontal_card.dart';
import 'package:hotel_manager/provider/home_menu.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:hotel_manager/screen/detail_card.dart';
import 'package:hotel_manager/screen/screen_product.dart';
import 'package:provider/provider.dart';

class PoolsSection extends StatefulWidget {
  PoolsSection({Key ?key}) : super(key: key);

  @override
  _PoolsSectionState createState() => _PoolsSectionState();
}

class _PoolsSectionState extends State<PoolsSection> {
  String _path = 'pools';
  bool _isLoad = true;
  List _listItem = [];
  @override
  void initState() { 
    super.initState();
    getItems();
  }

  getItems() async {
    List req = [];

    if(_isLoad)
      req = await ApiRouter.getSectionPoolForHome();

    if(req.length == 0) {
      setState(() {
        _isLoad = false;
      });
    } else {
      setState(() {
        context.read<HomeMenuProvider>().activateElementMenu(_path);
        _listItem.addAll(req);
        _isLoad = false;
      });
    }
  }
  // final List<MenuItem> _menuItem = context.watch<HomeMenuProvider>().homeMenuList;
  @override

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width * 0.65;
    return
    _isLoad
    ?
      HorizontalShimmer()
    :
      _listItem.length == 0
    ?
      Container() 
    :
    Column(
      children: [
        SizedBox(height: 15,),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ScreenProduct(title: 'Баcсейны',path: _path);
            }));
          },
          child: Container(
            margin: EdgeInsets.only(right: 15, left: 15, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Баcсейны', style: Theme.of(context).textTheme.headline1,),
                Image.asset('assets/icons/arrow.png', width: 8,)
              ],
            ),
          ),
        ),
        Container(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _listItem.length,
            itemBuilder: (ctx, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailCard(id: _listItem[i].id, path: _path,);
                  }));
                },
                child: HorizontalCard(card: _listItem[i])
              );
            }
          ),
        )
      ],
    );
  }
}