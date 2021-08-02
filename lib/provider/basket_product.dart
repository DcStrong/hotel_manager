import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_manager/model/basket_produts.dart';
import 'package:hotel_manager/model/food.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Basket with ChangeNotifier {
  List<BasketProducts> _basket = [];
  List<Food> _basketInFood = [];
  int _quantityPerson = 0;

  List<BasketProducts> get basketList => _basket;
  List<Food> get basketInFood => _basketInFood;
  int get quantityPerson => _quantityPerson;

  int get totalPrice =>
    _basketInFood.fold(0, (total, current) => total + (current.discountPrice ?? current.price! * current.quantity!));

  void listenProductBasket(List<BasketProducts> basketProduct) {
    _basket = basketProduct;
    notifyListeners();
  }

  decQuantityPerson() {
    if(_quantityPerson == 0) return;
    _quantityPerson = _quantityPerson - 1;
    notifyListeners();
  }

  incQuantityPerson() {
    _quantityPerson = _quantityPerson + 1;
    notifyListeners();
  }

  decreaseCountProductInBasket(Food food) {
    var element = _basketInFood.firstWhere((element) => element.id == food.id);
    food.quantity = element.quantity;
    food.quantity = food.quantity! - 1;
    if(food.quantity == 0) {
      _basketInFood.removeWhere((e) => e.id == food.id);
    }
    saveProductInCache();
    notifyListeners();
  }

  increaseCountProductInBasket(Food food) {
    if(_basketInFood.contains(food)) {
      food.quantity = food.quantity! + 1;
      saveProductInCache();
      notifyListeners();
    } else {
      return;
    }
  }

  addBasketProduct(Food food) {
    if(_basketInFood.contains(food)) {
      return;
    }
    food.quantity = 1;
    _basketInFood.add(food);
    saveProductInCache();
    notifyListeners();
  }

  clearBasketProduct() async {
    _basketInFood.clear();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.remove('basket');
    notifyListeners();
  }

  getBasketProduct(String token) async {
    _basket = await ApiRouter.getBasketFood(token);
  }

  saveProductInCache() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('basket', json.encode(_basketInFood));
  }

  getProductInBasketCache() async {
    List<Food> saveBasket;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    if(prefs.getKeys().contains('basket')) {
      List basketJson = jsonDecode(prefs.getString('basket') ?? '');
      saveBasket = basketJson.map<Food>((food) => Food.fromJSON(food)).toList();
      _basketInFood = saveBasket;
      notifyListeners();
    }
  }
}