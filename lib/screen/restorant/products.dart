import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/components/buttons/button_elevated.dart';
import 'package:hotel_manager/components/widget/basketNavBar.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/basket_produts.dart';
import 'package:hotel_manager/model/food.dart';
import 'package:hotel_manager/model/user.dart';
import 'package:hotel_manager/provider/basket_product.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsScreen extends StatefulWidget {
  final int id;
  ProductsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Food> foods = [];
  double? _widthCard;
  bool multiple = false;
  double? _width;
  double? _heightImage = 150;
  UserModel? _user;

  @override
  void initState() { 
    super.initState();
    getResoutantFoods();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _width = MediaQuery.of(context).size.width;
        if(_widthCard == null) {
          _widthCard = _width! / 2;
        }
        _user = Provider.of<User>(context, listen: false).userProfile;
      });
    });
  }

  allertDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Для того что бы продолжить, вам необходимо авторизироваться'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text('Закрыть'),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, 'auth'),
            child: Text('ОК'),
          ),
        ],
      ),
    );
  }

  getResoutantFoods() async {
    List<Food> result = await ApiRouter.getRestourantFoods(widget.id);
    setState(() {
      foods = result;
    });
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child:  IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('Меню', style: Theme.of(context).textTheme.headline1,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: ConfigColor.assentColor,
                  ),
                  onTap: () {
                    if(multiple) {
                      setState(() {
                        _widthCard = _width! / 2;
                        _heightImage = _widthCard! - 40;
                        multiple = !multiple;
                      });
                    } else {
                      setState(() {
                        _widthCard = _width;
                        _heightImage = 200;
                        multiple = !multiple;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardProduct(Food product) {
    return Container(
      padding: EdgeInsets.all(8),
      width: _widthCard,
      child: Neumorphic(
        style: NeumorphicStyle(
          color: ConfigColor.bgColor,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
          shadowLightColor: ConfigColor.shadowLightColor,
          shadowDarkColor: ConfigColor.shadowDarkColor.withOpacity(0.6),
        ),
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                width: _widthCard,
                height: _heightImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(product.preview, fit: BoxFit.cover,)
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: _widthCard,
                child: Text(product.title, style: Theme.of(context).textTheme.headline1 ,)
              ),
              SizedBox(height: 10,),
              Text('${product.weight.toString()} г', style: Theme.of(context).textTheme.bodyText1),
              SizedBox(height: 10,),
              Consumer<Basket>(
                builder: (BuildContext context, store, Widget? child) {
                  List<Food> basket = store.basketInFood;
                  var element = basket.where((e) => e.id == product.id);
                  if(element.isNotEmpty) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () async {
                            store.decreaseCountProductInBasket(product);
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            child: Icon(Icons.remove, color: ConfigColor.assentColor,),
                          ),
                        ),
                        Text(element.last.quantity.toString(), style: Theme.of(context).textTheme.headline2?.copyWith(color: ConfigColor.assentColor, fontWeight: FontWeight.w600)),
                        InkWell(
                          onTap: () async {
                            // var result = await ApiRouter.addBasketFood(product.id, _user!.token!);
                            store.increaseCountProductInBasket(product);
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            child: Icon(Icons.add, color: ConfigColor.assentColor,),
                          ),
                        ),
                    ],);
                  } else {
                    return 
                      buttonElevatedFullForPrice(
                        product.price.toString(),
                        context,
                        () async {
                          if (_user?.token != null) {
                            store.addBasketProduct(product);
                          } else {
                            allertDialog();
                          }
                        },
                        priceSale: product.discountPrice.toString()
                      );
                  }
                }
              )
          ],),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  children: foods.map((product) => cardProduct(product)).toList(),
                ),
              ),
            ),
          ],
        )
      ),
      bottomNavigationBar: basketNavBar()
    );
  }
}