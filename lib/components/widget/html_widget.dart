import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:hotel_manager/helper/config_color.dart';

Widget HtmlWidget(String data) {
  return Html(
    shrinkWrap: true,
    style: {
      "p": Style(
        fontSize: FontSize(16),
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
        color: ConfigColor.additionalColor,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
      ),
      "span": Style(
        fontSize: FontSize(16),
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
        color: ConfigColor.additionalColor,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
      )
    },
    data: data,
  );
}