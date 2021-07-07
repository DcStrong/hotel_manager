import 'package:flutter/material.dart';
import 'package:hotel_manager/components/widget/basketNavBar.dart';
import 'package:hotel_manager/components/widget/card/vertical_card.dart';
import 'package:hotel_manager/components/widget/card/vertical_card_restourant.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/card_model.dart';
import 'package:hotel_manager/model/restourant.dart';
import 'package:hotel_manager/provider/basket_product.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:provider/provider.dart';

class RestorantScreen extends StatefulWidget {
  RestorantScreen({Key? key}) : super(key: key);

  @override
  _RestorantScreenState createState() => _RestorantScreenState();
}

class _RestorantScreenState extends State<RestorantScreen> {

  List<Restourant> restourantList = [];

  @override
  void initState() { 
    super.initState();
    getRestorantList();
  }
  

  getRestorantList() async {
    List<Restourant> res = await ApiRouter.getRestorantList();
    setState(() {
      restourantList = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Рестораны', style: Theme.of(context).textTheme.headline1,),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
          child: ListView.builder(
            itemCount: restourantList.length,
            itemBuilder: (ctx, i) {
              return Padding(
                padding: EdgeInsets.only(bottom: 40.0),
                child: VerticalCardRestourant(
                    restourant: restourantList[i]
                  ),
              );
            }
          ),
        )
      ),
      bottomNavigationBar: basketNavBar()
    );
  }
}