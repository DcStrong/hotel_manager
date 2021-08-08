import 'package:hotel_manager/interface/model_interface.dart';

class CardWithTextModel implements ModelInterface {
  int id;
  String? image;
  String title;
  String? subtitle;
  String? body;
  List? slider;
  String? phone;

  CardWithTextModel({
    required this.id, 
    this.image, 
    this.subtitle, 
    required this.title, 
    this.body,
    this.slider,
    this.phone
  });

  factory CardWithTextModel.fromJSON(Map<String, dynamic> jsonMap) => CardWithTextModel(
    id: jsonMap['id'] ?? null,
    title: jsonMap['title'] ?? null,
    image: jsonMap['preview'] ?? null,
    phone: jsonMap['phone'] ?? null,
    subtitle: jsonMap['small_description'] ?? null,
    body: jsonMap['description'] ?? null,
    slider: jsonMap['slider'] ?? []
  );
}