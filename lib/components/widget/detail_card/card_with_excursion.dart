import 'package:flutter/material.dart';
import 'package:hotel_manager/components/widget/html_widget.dart';
import 'package:hotel_manager/components/widget/neumorphic_icon_container.dart';
import 'package:hotel_manager/interface/widget_interface.dart';
import 'package:hotel_manager/model/card_with_excursion.dart';

class CardWithExcursionType extends StatelessWidget implements WidgetInterface {
  final CardWithExcursionModel cardModel;

  CardWithExcursionType({Key? key, required this.cardModel}) : super(key: key);

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
                Text(cardModel.title!, style: Theme.of(context).textTheme.headline1,),
                SizedBox(height: 6,),
                Text(cardModel.subtitle!, style: Theme.of(context).textTheme.headline3,),
                SizedBox(height: 12,),
              ],
            ),
          ),
          neumorphicIconContainer(context, 'assets/icons/clock.png', cardModel.duration!),
          SizedBox(height: 6),
          neumorphicIconContainer(context, 'assets/icons/ruble.png', cardModel.price.toString()),
          SizedBox(height: 6),
          neumorphicIconContainer(context, 'assets/icons/personal.png', cardModel.guide!),
          SizedBox(height: 6),
          neumorphicIconContainer(context, 'assets/icons/telephone.png', cardModel.phone!),
          SizedBox(height: 15,),
          HtmlWidget(cardModel.body!),
      ],),
    );
  }
}