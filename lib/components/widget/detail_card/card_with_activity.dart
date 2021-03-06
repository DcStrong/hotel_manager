import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/button_elevated.dart';
import 'package:hotel_manager/components/widget/form/event_form.dart';
import 'package:hotel_manager/components/widget/html_widget.dart';
import 'package:hotel_manager/components/widget/neumorphic_icon_container.dart';
import 'package:hotel_manager/interface/widget_interface.dart';
import 'package:hotel_manager/model/card_with_activity.dart';

class CardWithActivityType extends StatelessWidget implements WidgetInterface {
  final CardWithActivityModel cardModel;

  CardWithActivityType({Key? key, required this.cardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 6,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cardModel.title ?? '', style: Theme.of(context).textTheme.headline1,),
                SizedBox(height: 6,),
                Text(cardModel.subtitle ?? '', style: Theme.of(context).textTheme.headline3,),
                SizedBox(height: 12,),
              ],
            ),
          ),
          HtmlWidget(cardModel.body ?? ''),
          if(cardModel.place != null)
          iconContainerForCard(context, 'assets/icons/gps.png', cardModel.place ?? ''),
          if(cardModel.date != null)
          iconContainerForCard(context, 'assets/icons/clock.png', cardModel.date ?? ''),
          if(cardModel.price != null)
          iconContainerForCard(context, 'assets/icons/ruble.png', cardModel.price ?? ''),
          buttonElevatedCenter('Записаться', context, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EventForm(activityId: cardModel.id,);
            }));
          }),
          SizedBox(height: 30,),
      ],),
    );
  }
}