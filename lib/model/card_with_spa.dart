import 'package:hotel_manager/interface/model_interface.dart';

class CardWithSpaModel implements ModelInterface {
  int? id;
  String? image;
  String? title;
  String? subtitle;
  String? body;
  String? email;
  String? time;
  String? phone;
  String? master;
  String? price;
  String? workingDays;
  int? categoryId;
  List? slider;

  CardWithSpaModel({
    this.id, 
    this.image, 
    this.subtitle, 
    this.title, 
    this.body, 
    this.slider, 
    this.price, 
    this.phone, 
    this.email, 
    this.master, 
    this.time,
    this.categoryId,
    this.workingDays,
  });

  factory CardWithSpaModel.fromJSON(Map<String, dynamic> jsonMap) => CardWithSpaModel(
    id: jsonMap['id'] ?? null,
    title: jsonMap['title'] ?? null,
    price: jsonMap['price'] != null ? converPriceIntTOString(jsonMap['price']) : null,
    workingDays: jsonMap['working_days'] ?? null,
    phone: jsonMap['phone'] ?? null,
    master: jsonMap['master_name'] ?? null,
    time: jsonMap['duration'] ?? null,
    email: jsonMap['email'] ?? null,
    image: jsonMap['preview'] ?? null,
    subtitle: jsonMap['small_description'] ?? null,
    body: jsonMap['description'] ?? null,
    categoryId: jsonMap['category_id'] ?? null,
    slider: jsonMap['slider'] ?? []
  );
}

converPriceIntTOString(dynamic price) {
  if (price is String) {
    return price;
  }

  return price.toString();
}