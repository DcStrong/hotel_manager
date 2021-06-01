import 'package:hotel_manager/interface/model_interface.dart';

class CardWithActivityModel implements ModelInterface {
  int? id;
  String? image;
  String? title;
  String? subtitle;
  String? body;
  String? date;
  String? place;
  int? active;

  CardWithActivityModel({
    this.id, 
    this.image, 
    this.subtitle, 
    this.title, 
    this.body, 
    this.date, 
    this.place,
    this.active,
  });

  factory CardWithActivityModel.fromJSON(Map<String, dynamic> jsonMap) => CardWithActivityModel(
    id: jsonMap['id'] ?? null,
    title: jsonMap['title'] ?? null,
    active: jsonMap['active'] ?? 0,
    place: jsonMap['place'] ?? null,
    date: jsonMap['date'] ?? null,
    image: jsonMap['preview'] ?? null,
    subtitle: jsonMap['small_description'] ?? null,
    body: jsonMap['description'] ?? null,
  );
}