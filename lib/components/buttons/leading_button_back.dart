import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_manager/helper/config_color.dart';

Widget iconButtonBack(BuildContext context) {
  return IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Icon(Icons.arrow_back_ios, color: ConfigColor.assentColor),
  );
}