class Food {
  int id;
  String preview;
  String title;
  String? price;
  String? discountPrice;
  int restaurantId;
  int? foodCategoryId;
  int? weight;
  int? quantity;

  Food({
    required this.id,
    required this.title,
    required this.preview,
    required this.price,
    this.discountPrice,
    required this.restaurantId,
    this.foodCategoryId,
    this.weight,
    this.quantity,
  });

  factory Food.fromJSON(Map<String, dynamic> jsonMap) => Food(
    id: jsonMap['id'],
    title: jsonMap['title'],
    preview: jsonMap['preview'] ?? '',
    discountPrice: jsonMap['discount_price'] != null ? jsonMap['discount_price'].toString() : null,
    price: jsonMap['price'] != null ? jsonMap['price'].toString() : null,
    restaurantId: jsonMap['restaurant_id'],
    foodCategoryId: jsonMap['food_category_id'] ?? null,
    weight: jsonMap['weight'] ?? null
  );
}


