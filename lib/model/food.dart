class Food {
  int id;
  String? preview;
  String title;
  int? price;
  int? discountPrice;
  int restaurantId;
  int? foodCategoryId;
  String? weight;
  int? quantity;

  Food({
    required this.id,
    required this.title,
    required this.preview,
    this.price,
    this.discountPrice,
    required this.restaurantId,
    this.foodCategoryId,
    this.weight,
    this.quantity,
  });

  Map<String, dynamic> toJson() => toJsonItem(this);

  factory Food.fromJSON(Map<String, dynamic> jsonMap, {int? quant}) => Food(
    id: jsonMap['id'],
    title: jsonMap['title'],
    preview: jsonMap['preview'] ?? null,
    discountPrice: jsonMap['discount_price'],
    price: jsonMap['price'],
    restaurantId: jsonMap['restaurant_id'],
    foodCategoryId: jsonMap['food_category_id'] ?? null,
    weight: jsonMap['weight'] != null ? jsonMap['weight'].toString() : null,
    quantity: quant != null ? quant : jsonMap['quantity'] ?? 1,
  );

  Map<String, dynamic> toJsonItem(Food food) => {
    'id': id,
    "preview": preview,
    "title": title,
    "price": price,
    "discount_price": discountPrice,
    "restaurant_id": restaurantId,
    "food_category_id": foodCategoryId,
    "weight": weight,
    "quantity": quantity ?? 1,
  };
}


