import 'package:hotel_manager/interface/model_interface.dart';

class CardWithTextModel implements ModelInterface {
  int? id;
  String? image;
  String? title;
  String? subtitle;
  String? body;
  List? slider;

  CardWithTextModel({this.id, this.image, this.subtitle, this.title, this.body, this.slider});

  factory CardWithTextModel.fromJSON(Map<String, dynamic> jsonMap) => CardWithTextModel(
    id: jsonMap['id'] ?? null,
    title: jsonMap['title'] ?? null,
    image: jsonMap['preview'] ?? null,
    subtitle: jsonMap['small_description'] ?? null,
    body: jsonMap['description'] ?? null,
    slider: jsonMap['slider'] ?? []
  );
}