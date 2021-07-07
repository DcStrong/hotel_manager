import 'package:flutter/material.dart';
import 'package:hotel_manager/helper/config_color.dart';

Widget buttonElevatedCenter(String text, BuildContext context, Function func) {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: ConfigColor.assentColor,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: (){
          func();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(text, style: Theme.of(context).textTheme.headline1?.copyWith(color: Colors.white)),
        ),
      )
    ),
  );
}

Widget buttonElevatedFullForPrice(String price, BuildContext context, Function func, {String? priceSale}) {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: ConfigColor.assentColor,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: (){
          func();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${price} ₽', style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
              if (priceSale != null)
                Text(priceSale, style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.white, decoration: TextDecoration.lineThrough, fontSize: 13)),
            ],
          ),
        ),
      )
    ),
  );
}

Widget buttonElevated(String text, BuildContext context, Function func) {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: ConfigColor.assentColor,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  return Container(
    child: ElevatedButton(
      style: raisedButtonStyle,
      onPressed: (){
        func();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(text, style: Theme.of(context).textTheme.headline1?.copyWith(color: Colors.white)),
      ),
    )
  );
}