import 'package:hotel_manager/interface/model_interface.dart';

class CardWithExcursionModel implements ModelInterface {
  int? id;
  String? image;
  String? title;
  String? subtitle;
  String? body;
  String? destination;
  String? date;
  String? duration;
  int? active;
  String? price;
  String? phone;
  String? guide;

  CardWithExcursionModel({
    this.id, 
    this.image, 
    this.subtitle, 
    this.title, 
    this.body, 
    this.destination, 
    this.date, 
    this.duration,
    this.active,
    this.phone,
    this.price,
    this.guide,
  });

  factory CardWithExcursionModel.fromJSON(Map<String, dynamic> jsonMap) => CardWithExcursionModel(
    id: jsonMap['id'] ?? null,
    title: jsonMap['title'] ?? null,
    active: jsonMap['active'] ?? 0,
    guide: jsonMap['guide'] ?? null,
    phone: jsonMap['phone'] ?? null,
    price: jsonMap['price'] != null ? jsonMap['price'].toString() : null,
    destination: jsonMap['destination'] ?? null,
    date: jsonMap['date'] ?? null,
    image: jsonMap['preview'] ?? null,
    duration: jsonMap['duration'] ?? null,
    subtitle: jsonMap['small_description'] ?? null,
    body: jsonMap['description'] ?? null,
  );
}