class CardModel {
  int? id;
  String? image;
  String? title;
  String? subtitle;
  String? date;
  int? typeId;

  CardModel({this.id, this.image, this.subtitle, this.title, this.date, this.typeId});

  factory CardModel.fromJSON(Map<String, dynamic> jsonMap) => CardModel(
    id: jsonMap['id'] ?? null,
    title: jsonMap['title'] ?? null,
    image: jsonMap['preview'] ?? null,
    subtitle: jsonMap['small_description'] ?? null,
    typeId: jsonMap['type_id'] ?? 0,
    date: jsonMap['date'] ?? DateTime.now().toString()
  );
}