import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/button_text.dart';
import 'package:hotel_manager/components/buttons/leading_button_back.dart';
import 'package:hotel_manager/components/shimmer/vertical_shimmer.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/user_food.dart';
import 'package:hotel_manager/repository/api_router.dart';

class DetailCardMyOrder extends StatefulWidget {
  const DetailCardMyOrder({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _DetailCardMyOrderState createState() => _DetailCardMyOrderState();
}

class _DetailCardMyOrderState extends State<DetailCardMyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ваш заказ', style: Theme.of(context).textTheme.headline1,),
        shadowColor: Colors.transparent,
        backgroundColor: ConfigColor.bgColor,
        leading: iconButtonBack(context),
      ),
      body: FutureBuilder(
        initialData: null,
        future: ApiRouter.getDetailMyOrder(widget.id),
        builder: (ctx, AsyncSnapshot<UserFoodDetail?> snapshot) {
          print(snapshot);
          if(snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  buttonText('Отменить заказ', context, func: () {}, isPadding: false),
                  Text('Заказ №${snapshot.data?.id}'),
                  SizedBox(height: 10),
                  Text('Корпус: ${snapshot.data?.corps}'),
                  SizedBox(height: 10),
                  Text('Комната №${snapshot.data?.roomNumber}'),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Комментарий к заказу:'),
                      Text(snapshot.data?.comment ?? 'Не указан')
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Количество человек: ${snapshot.data?.peopleCount}'),
                  SizedBox(height: 10),
                  Text('Время доставки: ${snapshot.data?.deliveryAt}'),
                  SizedBox(height: 10),
                  Text('Статус заказа: ${snapshot.data?.status.value}'),
                  SizedBox(height: 10),
                  Text('Тип заказа: ${snapshot.data?.orderType.value}'),
                  SizedBox(height: 10),
                  Text('Общая сумма заказа: ${snapshot.data?.price}'),
                  SizedBox(height: 10),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.foods.length,
                    itemBuilder: (ctx, i) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Row(children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              constraints: BoxConstraints(
                                minHeight: 50,
                                maxHeight: 100,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  snapshot.data!.foods[i].preview ?? '', 
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
                                  minHeight: 50,
                                  maxHeight: 100,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data!.foods[i].title,  style: Theme.of(context).textTheme.headline1),
                                      Text('x${snapshot.data!.foods[i].quantity.toString()}',  style: Theme.of(context).textTheme.headline2),
                                    ],
                                  ),
                                  snapshot.data!.foods[i].discountPrice != null 
                                  ?
                                  Text('${snapshot.data!.foods[i].discountPrice! * snapshot.data!.foods[i].quantity!} р', style: Theme.of(context).textTheme.bodyText1)
                                  :
                                  Text('${snapshot.data!.foods[i].price! * snapshot.data!.foods[i].quantity!} р', style: Theme.of(context).textTheme.bodyText1),
                                ],),
                              ),
                            ),
                          )
                        ],),
                      );
                    }
                  ),
                  SizedBox(height: 10),
                  Text('***Стоимость блюд указана на текущий период времени'),
                ],),
              ),
            );
          }
          return VerticalShimmer();
        }
      ),
    );
  }
}