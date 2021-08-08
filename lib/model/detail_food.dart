class DetailFood {
  int id;
  String title;
  String? description;
  int price;
  int? discountPrice;
  int? weight;
  String? ingredients;
  String? proteins;
  String? fats;
  String? carbohydrates;
  int? restourantId;

  DetailFood({
    required this.id,
    required this.title,
    this.description,
    this.restourantId,
    required this.price,
    this.discountPrice,
    this.weight,
    this.ingredients,
    this.proteins,
    this.fats,
    this.carbohydrates,
  });

   factory DetailFood.fromJSON(Map<String, dynamic> jsonMap) => DetailFood(
    id: jsonMap['id'],
    title: jsonMap['title'],
    description: jsonMap['description'] ?? null,
    price: jsonMap['price'],
    discountPrice: jsonMap['discount_price'] ?? null,
    weight: jsonMap['weight'] ?? null,
    ingredients: jsonMap['ingredients'] ?? null,
    proteins: jsonMap['proteins'] ?? null,
    fats: jsonMap['fats'] ?? null,
    carbohydrates: jsonMap['carbohydrates'] ?? null,
    restourantId: jsonMap['restaurant_id'] ?? null
  );
}