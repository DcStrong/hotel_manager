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
  int? price;
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
  });

  factory CardWithSpaModel.fromJSON(Map<String, dynamic> jsonMap) => CardWithSpaModel(
    id: jsonMap['id'] ?? null,
    title: jsonMap['title'] ?? null,
    price: jsonMap['price'] != null ? int.parse(jsonMap['price'].toString()) : null,
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