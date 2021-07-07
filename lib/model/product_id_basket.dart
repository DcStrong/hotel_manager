import 'package:hotel_manager/model/food.dart';

class ProductInBasket {
  int quantity;
  Food food;

  ProductInBasket({
    required this.food,
    required this.quantity
  });

  factory ProductInBasket.fromJSON(Map<String, dynamic> jsonMap) => ProductInBasket(
    quantity: jsonMap['quantity'],
    food: jsonMap['food'],
  );

   Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'food': food,
    };
  }
}

Food mapCuisines(dynamic map){
  return Food.fromJSON(map);
}