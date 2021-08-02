import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/leading_button_back.dart';
import 'package:hotel_manager/components/shimmer/vertical_shimmer.dart';
import 'package:hotel_manager/components/widget/basketNavBar.dart';
import 'package:hotel_manager/components/widget/card/vartical_card_restourant.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/restourant.dart';
import 'package:hotel_manager/repository/api_router.dart';

class RestorantScreen extends StatefulWidget {
  RestorantScreen({Key? key}) : super(key: key);

  @override
  _RestorantScreenState createState() => _RestorantScreenState();
}

class _RestorantScreenState extends State<RestorantScreen> {
  bool _isLoad = true;

  List<Restourant> restourantList = [];

  @override
  void initState() { 
    super.initState();
    getRestorantList();
  }
  

  getRestorantList() async {
    List<Restourant> res = await ApiRouter.getRestorantList();
    if(res.length != 0)
      setState(() {
        restourantList = res;
      });
    setState(() {
      _isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Рестораны', style: Theme.of(context).textTheme.headline1,),
        shadowColor: Colors.transparent,
        backgroundColor: ConfigColor.bgColor,
      ),
      body:
      _isLoad
      ?
        VerticalShimmer()
      :
        restourantList.length == 0
      ?
        Container()
      :
      SafeArea(
        child: Container(
          child: ListView.builder(
            itemCount: restourantList.length,
            itemBuilder: (ctx, i) {
              return VerticalCardRestourant(
                restourant: restourantList[i]
              );
            }
          ),
        )
      ),
      bottomNavigationBar: basketNavBar()
    );
  }
}