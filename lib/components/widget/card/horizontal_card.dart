import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/card_model.dart';

class HorizontalCard extends StatefulWidget {
  final CardModel card;
  HorizontalCard({Key? key, required this.card}) : super(key: key);

  @override
  _HorizontalCardState createState() => _HorizontalCardState();
}

class _HorizontalCardState extends State<HorizontalCard> {
  double width = 285.0;
  double height = 200.0;
  double imageHeight = 133.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Neumorphic(
            style: NeumorphicStyle(
              color: ConfigColor.bgColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
              shadowLightColor: ConfigColor.shadowLightColor,
              shadowDarkColor: ConfigColor.shadowDarkColor.withOpacity(0.6),
            ),
            child: Container(
              // padding: EdgeInsets.all(2),
              width: this.width, height: this.height,
              child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  height: this.imageHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    child: Image.network(widget.card.image!, fit: BoxFit.fitWidth, width: this.width)
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 14, right: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Container(
                          width: 240,
                          child: Text(widget.card.title ?? '', style: Theme.of(context).textTheme.headline2, overflow: TextOverflow.ellipsis,)
                        ),
                        SizedBox(height: 4,),
                        Container(
                          width: 240,
                          child: Text(widget.card.subtitle ?? '', style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.ellipsis,))
                      ],),
                      Image.asset('assets/icons/arrow.png', width: 8,)
                    ],),
                  ),
                )
              ],),
            ),
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}