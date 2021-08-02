import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/helper/config_color.dart';

Widget iconContainerForCard(context, String icon, String text) {
  return Container(
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 1, color: Colors.grey.withOpacity(0.3)))
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          Image.asset(
            icon,
            color: ConfigColor.assentColor,
            width: 30,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.headline2)
          ),
        ],
      ),
    ),
  );
}