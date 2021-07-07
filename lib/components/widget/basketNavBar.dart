import 'package:flutter/material.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/provider/basket_product.dart';
import 'package:provider/provider.dart';

Widget basketNavBar({bool isBasket = false}) {
  return  Consumer<Basket>(
    builder: (BuildContext context, store, Widget? child) {
      return
        store.basketInFood.length > 0 ?
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, isBasket ? 'basket_order' : 'basket');
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: ConfigColor.assentColor,
                borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isBasket ? 'Заказать: ' : 'Cумма заказа: ',  style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                  Text(store.totalPrice.toString(), style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.white)),
                ],
              ),
            ),
          ),
        ) : SizedBox();
    }
  );
}