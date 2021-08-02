import 'package:flutter/material.dart';
import 'package:hotel_manager/helper/config_color.dart';

Widget outlineButton(IconData icon, String text, VoidCallback press ) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Color(0xFFF5F6F9),
        primary: ConfigColor.assentColor,
        textStyle: TextStyle(
          fontFamily: 'MontseratMedium',
          color: ConfigColor.assentColor,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        side: BorderSide(
          width: 0,
          color: Colors.transparent
        ),
      ),
      onPressed: () {
        press();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 20),
              Expanded(
                child: Text(text)
              ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    ),
  );
}