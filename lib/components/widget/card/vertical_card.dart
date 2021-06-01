import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/card_model.dart';

class VerticalCard extends StatefulWidget {
  final CardModel card;
  VerticalCard({Key? key, required this.card}) : super(key: key);

  @override
  _VerticalCardState createState() => _VerticalCardState();
}

class _VerticalCardState extends State<VerticalCard> {
  double imageHeight = 150;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width * 0.54;
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.only(left: 10),
          child: Neumorphic(
            style: NeumorphicStyle(
              color: ConfigColor.bgColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
              shadowLightColor: ConfigColor.shadowLightColor,
              shadowDarkColor: ConfigColor.shadowDarkColor.withOpacity(0.6),
            ),
            child: Container(
              // padding: EdgeInsets.all(2),
              width: width, height: height,
              child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  height: imageHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    child: Image.network(widget.card.image!, fit: BoxFit.fitWidth, width: width)
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
                          width: 300,
                          child: Text(widget.card.title ?? '', style: Theme.of(context).textTheme.headline2,overflow: TextOverflow.ellipsis,)
                        ),
                        widget.card.subtitle != null ?
                        Text(widget.card.subtitle ?? '', style: Theme.of(context).textTheme.bodyText1,)
                        : Container()
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