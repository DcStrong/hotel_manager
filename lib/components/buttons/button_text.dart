import 'package:flutter/material.dart';
import 'package:hotel_manager/helper/config_color.dart';

Widget buttonText(String text, BuildContext context, {Color ?color, Function ?func, bool isPadding = true}) {

  final ButtonStyle textButtonStyle = TextButton.styleFrom(
    primary: color ?? ConfigColor.assentColor,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: isPadding ? 12 : 0),
  );

  return Container(
    child: TextButton(
      style: textButtonStyle,
      onPressed: () {
        func!();
      },
      child: Text(text, style: TextStyle(fontFamily: 'MontseratMedium', fontSize: 14, fontWeight: FontWeight.w600),),
    ),
  );
}