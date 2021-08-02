import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/components/buttons/button_elevated.dart';
import 'package:hotel_manager/components/buttons/button_text.dart';
import 'package:hotel_manager/components/widget/card/detail_card_my_order.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/food.dart';
import 'package:hotel_manager/model/user_food.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:provider/provider.dart';

class VerticalCardMyOrder extends StatefulWidget {
  final UserFood item;
  VerticalCardMyOrder({Key? key, required this.item}) : super(key: key);

  @override
  _VerticalCardRestoMyOrder createState() => _VerticalCardRestoMyOrder();
}

class _VerticalCardRestoMyOrder extends State<VerticalCardMyOrder> {
  double imageHeight = 150;
  double defaultHeightCuisines = 25;
  double? heightCuisines;
  double? _height = 0;
  double _heightCard = 70;

  List<Food> foodList = [];

  @override
  void initState() { 
    super.initState();
  }

  Widget foodItem(Food item, BuildContext context) {
    return Container(
      height: _heightCard,
      child: Row(children: [
        Container(
          width: 80,
          child: Image.network(item.preview),
        ),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200,
              child: Text(item.title, style: Theme.of(context).textTheme.headline1,)
            ),
            SizedBox(height: 10,),
            Text(item.price.toString(), style: Theme.of(context).textTheme.headline2)
        ],)
      ],),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, user, _) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailCardMyOrder(id: widget.item.id);
              }));
          },
          child: Container(
            child: Neumorphic(
              style: NeumorphicStyle(
                color: ConfigColor.bgColor,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                shadowLightColor: ConfigColor.shadowLightColor,
                shadowDarkColor: ConfigColor.shadowDarkColor.withOpacity(0.6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12, top: 10, bottom: 10, right: 12),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Заказ ${widget.item.id}", style: Theme.of(context).textTheme.headline1, overflow: TextOverflow.ellipsis,),
                          Text('${widget.item.status.value}', style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      )
                    ),
                  ),
              ],)
            )
          ),
        );
      }
    );
  }
}


                  // AnimatedContainer(
                  //   padding: EdgeInsets.only(left: 12, right: 12),
                  //   margin: EdgeInsets.only(bottom: 10),
                  //   height: _height,
                  //   curve: Curves.fastOutSlowIn,
                  //   duration: Duration(milliseconds: 800),
                  //   child: SingleChildScrollView(
                  //     physics: NeverScrollableScrollPhysics(),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         SizedBox(height: 15,),
                  //         foodList.length == 0 
                  //         ?
                  //         Center(
                  //           child: CircularProgressIndicator(),
                  //         )
                  //         :
                  //         ListView.builder(
                  //           physics: NeverScrollableScrollPhysics(),
                  //           shrinkWrap: true,
                  //           itemCount: foodList.length,
                  //           itemBuilder: (ctx, i) {
                  //             return foodItem(foodList[i], ctx);
                  //           }
                  //         ),
                  //         SizedBox(height: 15,),
                  //         // Text('Количество персон: ${widget.item.peopleCount}', style: Theme.of(context).textTheme.headline2,),
                  //         SizedBox(height: 15,),
                  //         // Text('Общая сумма заказа: ${widget.item.price}', style: Theme.of(context).textTheme.headline2,),
                  //         SizedBox(height: 15,),
                  //         buttonText('Отменить заказ', context, func: () {}, isPadding: false),
                  //         SizedBox(height: 15,),
                  //     ],),
                  //   ),
                  // ),