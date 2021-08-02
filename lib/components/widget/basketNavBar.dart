import 'package:flutter/material.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/helper/helper.dart';
import 'package:hotel_manager/model/user.dart';
import 'package:hotel_manager/provider/basket_product.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

Widget basketNavBar({bool isBasket = false}) {
  return  Consumer<User>(
    builder: (BuildContext context, user, _) {
      UserModel _user = user.userProfile;
      return Consumer<Basket>(
        builder: (BuildContext context, store, Widget? child) {
          if(_user.token == null)
            store.clearBasketProduct();
          return
            store.basketInFood.length > 0 ?
            GestureDetector(
              onTap: () {
                if(isBasket && store.quantityPerson == 0) {
                  helper.showMessageSnackBar(context, 'Укажите количество персон');
                  return;
                }
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
                  padding: EdgeInsets.only(left: 5, right: 5, top: 12, bottom: 12),
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
  );
}