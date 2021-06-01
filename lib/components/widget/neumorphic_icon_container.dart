import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/helper/config_color.dart';

Widget neumorphicIconContainer(context, String icon, String text) {
  return Container(
    child: Neumorphic(
      style: NeumorphicStyle(
        color: ConfigColor.bgColor,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        shadowLightColor: ConfigColor.shadowLightColor,
        shadowDarkColor: ConfigColor.shadowDarkColor.withOpacity(0.6),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 26,
              child: Image.asset(icon, color: ConfigColor.assentColor,),
            ),
            SizedBox(width: 12,),
            Text(text, style: Theme.of(context).textTheme.headline1,),
          ],
        )
      ),
    ),
  );
}