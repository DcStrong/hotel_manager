import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:hotel_manager/helper/config_color.dart';

Widget HtmlWidget(String data) {
  return Html(
    shrinkWrap: true,
    style: {
      "p": Style(
        fontSize: FontSize(14),
        letterSpacing: 0.25,
        color: ConfigColor.additionalColor,
        fontFamily: 'MontseratRegular',
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
      ),
      "div": Style(
        fontSize: FontSize(14),
        letterSpacing: 0.25,
        fontFamily: 'MontseratRegular',
        color: ConfigColor.additionalColor,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
      ),
      "h2": Style(
        fontSize: FontSize(14),
        letterSpacing: 0.25,
        fontFamily: 'MontseratRegular',
        color: ConfigColor.additionalColor,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
      ),
      "h1": Style(
        fontSize: FontSize(14),
        letterSpacing: 0.25,
        fontFamily: 'MontseratRegular',
        color: ConfigColor.additionalColor,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
      ),
      "span": Style(
        fontSize: FontSize(14),
        letterSpacing: 0.25,
        fontFamily: 'MontseratRegular',
        color: ConfigColor.additionalColor,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
      )
    },
    data: data,
  );
}