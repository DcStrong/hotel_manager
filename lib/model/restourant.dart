class Restourant {
  int id;
  String preview;
  String title;
  String? description;
  String? openTime;
  String? closeTime;
  String? deliveryTime;
  List<Cuisines> cuisines = [];


  Restourant({
    required this.id,
    required this.title,
    required this.preview,
    this.openTime,
    this.description,
    this.closeTime,
    this.deliveryTime,
    required this.cuisines
  });

  factory Restourant.fromJSON(Map<String, dynamic> jsonMap) => Restourant(
    id: jsonMap['id'],
    title: jsonMap['title'],
    preview: jsonMap['preview'] ?? '',
    description: jsonMap['descriptions'],
    openTime: jsonMap['open_time'] ?? 0,
    closeTime: jsonMap['close_time'] ?? 0,
    deliveryTime: jsonMap['delivery_time'] ?? 0,
    cuisines: mapCuisines(jsonMap['cuisines'])
  );
}

List<Cuisines> mapCuisines(dynamic map){
  List<Cuisines> list = [];
  map.forEach((e) {
     list.add(Cuisines.fromMap(e));
  });
  return list;
}

class Cuisines {
  int id;
  String title;
  String subtitle;
  int active;

  Cuisines({
    required this.active,
    required this.id,
    required this.title,
    required this.subtitle,
  });

  factory Cuisines.fromMap(Map json) {
    Cuisines cuisines = Cuisines(
      id: json['id'],
      active: json['active'] ?? 0,
      title: json['title'],
      subtitle: json['subtitle']
    );
    return cuisines;
  }
}