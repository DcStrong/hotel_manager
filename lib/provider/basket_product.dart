import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_manager/model/basket_produts.dart';
import 'package:hotel_manager/model/food.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Basket with ChangeNotifier {
  List<BasketProducts> _basket = [];
  List<Food> _basketInFood = [];

  List<BasketProducts> get basketList => _basket;
  List<Food> get basketInFood => _basketInFood;

  int get totalPrice =>
    _basketInFood.fold(0, (total, current) => total + (int.parse(current.price!) * current.quantity!));

  void listenProductBasket(List<BasketProducts> basketProduct) {
    _basket = basketProduct;
    notifyListeners();
  }

  decreaseCountProductInBasket(Food food) {
    if(_basketInFood.contains(food)) {
      food.quantity = food.quantity! - 1;
      if(food.quantity == 0) {
        _basketInFood.removeWhere((e) => e.id == food.id);
      }
      notifyListeners();
    } else {
      return;
    }
  }

  increaseCountProductInBasket(Food food) {
    if(_basketInFood.contains(food)) {
      food.quantity = food.quantity! + 1;
      notifyListeners();
    } else {
      return;
    }
  }

  addBasketProduct(Food food) async {
    if(_basketInFood.contains(food)) {
      return;
    }

    food.quantity = 1;
    _basketInFood.add(food);
    notifyListeners();
  }

  getBasketProduct(String token) async {
    _basket = await ApiRouter.getBasketFood(token);
  }
}