import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/components/buttons/button_elevated.dart';
import 'package:hotel_manager/components/buttons/button_neumorphic.dart';
import 'package:hotel_manager/components/buttons/leading_button_back.dart';
import 'package:hotel_manager/components/tab_navigator/tab_navigator.dart';
import 'package:hotel_manager/components/widget/basketNavBar.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/basket_produts.dart';
import 'package:hotel_manager/model/food.dart';
import 'package:hotel_manager/provider/basket_product.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:provider/provider.dart';

class BasketScreen extends StatefulWidget {
  BasketScreen({Key? key}) : super(key: key);

  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  double? _widthCard = 250;
  double? _heightImage = 150;
  double? allPrice;

  @override
  void dispose() {
    super.dispose();
  }

  Widget cardProduct() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Consumer<Basket>(
        builder: (BuildContext context, _store, _) {
          return _store.basketInFood.length == 0
          ?
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Корзина пустая', style: Theme.of(context).textTheme.headline2,),
                      SizedBox(height: 30,),
                      buttonElevatedCenter('Вернуться к выбору', context, () {
                        Navigator.pushNamedAndRemoveUntil(context, 'restorant', (route) => false);
                      })
                    ],
                  ),
                )
              )
          :
            SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _store.basketInFood.length,
                    itemBuilder: (ctx, i) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: Neumorphic(
                          style: NeumorphicStyle(
                            color: ConfigColor.bgColor,
                            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                            shadowLightColor: ConfigColor.shadowLightColor,
                            shadowDarkColor: ConfigColor.shadowDarkColor.withOpacity(0.6),
                          ),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  constraints: BoxConstraints(
                                    minHeight: 150,
                                    maxHeight: 170,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      _store.basketInFood[i].preview ?? '',
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                        return Center(
                                          child: Image.asset(
                                            'assets/img/image_not_found.jpg',
                                            fit: BoxFit.fitWidth,
                                          )
                                        );
                                      },
                                    )
                                  ),
                                ),
                              ),
                              Flexible(
                                child: IntrinsicHeight(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    constraints: BoxConstraints(
                                      minHeight: 150,
                                      maxHeight: 250,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text(_store.basketInFood[i].title,  style: Theme.of(context).textTheme.headline1),
                                      Text('${_store.basketInFood[i].price! * _store.basketInFood[i].quantity!} р', style: Theme.of(context).textTheme.bodyText1),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          flatButtonNeumorphic(Icons.remove, () {_store.decreaseCountProductInBasket(_store.basketInFood[i]);}),
                                          Container(
                                            padding: EdgeInsets.only(left: 5, right: 5),
                                            child: Center(
                                              child: Text(
                                                _store.basketInFood[i].quantity.toString(), 
                                                style: Theme.of(context).textTheme.headline2?.copyWith(color: ConfigColor.assentColor, fontWeight: FontWeight.w600)
                                              ),
                                            )
                                          ),
                                          flatButtonNeumorphic(Icons.add, () {_store.increaseCountProductInBasket(_store.basketInFood[i]);}),
                                        ],
                                      ),
                                    ],),
                                  ),
                                ),
                              )
                            ],),
                          )
                        ),
                      );
                    }
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text('Количество персон', style: Theme.of(context).textTheme.headline1,),
                      Row(
                        children: [
                          flatButtonNeumorphic(Icons.remove, () {_store.decQuantityPerson();}),
                          Container(
                            child: Center(
                              child: Text(
                                '${_store.quantityPerson}',
                                style: Theme.of(context).textTheme.headline2?.copyWith(color: ConfigColor.assentColor, fontWeight: FontWeight.w600)
                              ),
                            )
                          ),
                          flatButtonNeumorphic(Icons.add, () {_store.incQuantityPerson();})
                        ],
                      ),
                    ],),
                  )
                ],
              ),
            );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина', style: Theme.of(context).textTheme.headline1,),
        shadowColor: Colors.transparent,
        backgroundColor: ConfigColor.bgColor,
        leading: iconButtonBack(context),
      ),
      body: cardProduct(),
      bottomNavigationBar: basketNavBar(isBasket: true)
    );
  }
}