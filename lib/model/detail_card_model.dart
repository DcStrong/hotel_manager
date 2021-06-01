class DetailCardModel {
  String? id;
  String? image;
  String? title;
  String? subtitle ;
  String? body;
  DetailCardModel({
    this.id,
    this.body,
    this.title,
    this.subtitle,
    this.image,
  });

  factory DetailCardModel.fromJSON(Map<String, dynamic> jsonMap) => DetailCardModel(
    id: jsonMap['id'] ?? null,
    title: jsonMap['title'] ?? null,
    image: jsonMap['image'] ?? null,
    subtitle: jsonMap['subtitle'] ?? null,
    body: jsonMap['body'] ?? null,
  );
}