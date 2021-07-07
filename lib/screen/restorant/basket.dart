import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/components/buttons/button_elevated.dart';
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
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Widget cardProduct() {
    return Consumer<Basket>(
      builder: (BuildContext context, _store, _) {
        return ListView.builder(
          itemCount: _store.basketInFood.length,
          itemBuilder: (ctx, i) {
            return Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              child: Neumorphic(
                style: NeumorphicStyle(
                  color: ConfigColor.bgColor,
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                  shadowLightColor: ConfigColor.shadowLightColor,
                  shadowDarkColor: ConfigColor.shadowDarkColor.withOpacity(0.6),
                ),
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          constraints: BoxConstraints(maxHeight: _heightImage!),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(_store.basketInFood[i].preview, fit: BoxFit.cover,)
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          constraints: BoxConstraints( maxHeight: _heightImage!),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                width: _widthCard,
                                child: Text(_store.basketInFood[i].title, style: Theme.of(context).textTheme.headline1 ,)
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        _store.decreaseCountProductInBasket(_store.basketInFood[i]);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        width: 48,
                                        height: 48,
                                        child: Icon(Icons.remove, color: ConfigColor.assentColor,),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 15, right: 15),
                                      child: Text(
                                        _store.basketInFood[i].quantity.toString(), 
                                        style: Theme.of(context).textTheme.headline2?.copyWith(color: ConfigColor.assentColor, fontWeight: FontWeight.w600)
                                      )
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        _store.increaseCountProductInBasket(_store.basketInFood[i]);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        width: 48,
                                        height: 48,
                                        child: Icon(Icons.add, color: ConfigColor.assentColor,),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('${int.parse(_store.basketInFood[i].price!) * _store.basketInFood[i].quantity!} р', style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(height: 10,),
                  ],),
                ),
              ),
            );
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
      ),
      body: cardProduct(),
      bottomNavigationBar: basketNavBar(isBasket: true)
    );
  }
}