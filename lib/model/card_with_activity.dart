import 'package:hotel_manager/interface/model_interface.dart';
import 'package:intl/intl.dart';

class CardWithActivityModel implements ModelInterface {
  int? id;
  String? image;
  String? title;
  String? subtitle;
  String? body;
  String? date;
  String? place;
  String? price;
  String? time;
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
    this.price,
    this.time
  });

  factory CardWithActivityModel.fromJSON(Map<String, dynamic> jsonMap) => CardWithActivityModel(
    id: jsonMap['id'] ?? null,
    title: jsonMap['title'] ?? null,
    active: jsonMap['active'] ?? 0,
    time: jsonMap['time'] ?? null,
    price: jsonMap['price'] ?? null,
    place: jsonMap['place'] ?? null,
    date: jsonMap['date'] != null ? converDate(jsonMap['date']) : null,
    image: jsonMap['preview'] ?? null,
    subtitle: jsonMap['small_description'] ?? null,
    body: jsonMap['description'] ?? null,
  );
}

converDate(String date) {
  var dateTime = DateTime.parse(date);
  var formatDate = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
  return formatDate;
}