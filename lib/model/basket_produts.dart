import 'package:hotel_manager/model/food.dart';

class BasketProducts {
  int id;
  int userId;
  int foodId;
  int quantity;
  Food food;

  BasketProducts({
    required this.food,
    required this.foodId,
    required this.id,
    required this.quantity,
    required this.userId
  });

  factory BasketProducts.fromJSON(Map<String, dynamic> jsonMap) => BasketProducts(
    id: jsonMap['id'],
    userId: jsonMap['user_id'],
    foodId: jsonMap['food_id'],
    quantity: jsonMap['quantity'],
    food: mapCuisines(jsonMap['food']),
  );

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'food_id': foodId,
      'quantity': quantity,
      'food': mapCuisines(food),
    };
  }
}

Food mapCuisines(dynamic map){
  return Food.fromJSON(map);
}