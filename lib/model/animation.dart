import 'package:intl/intl.dart';

class AnimationModel {
  int? id;
  String? title;
  String? description;
  String? place;
  int? typeId;
  int? active;
  int? forAdults;
  List<AnimationTimes>? animationTimes = [];
  String? startTime = '';
  String? endTime = '';


  AnimationModel({this.id, this.title, this.active, this.description, this.forAdults, this.place, this.typeId, this.animationTimes, this.startTime, this.endTime});

  factory AnimationModel.fromJSON(Map<String, dynamic> jsonMap) => AnimationModel(
    id: jsonMap['id'] ?? '',
    title: jsonMap['title'] ?? '',
    description: jsonMap['description'] ?? '',
    place: jsonMap['place'] ?? '',
    typeId: jsonMap['type_id'] ?? null,
    active: jsonMap['active'] ?? null,
    forAdults: jsonMap['for_adults'] ?? null,
    animationTimes: mapAnimationTimes(jsonMap['times']),
  );
}

timeParseDateTime(String time) {
  DateTime timeFormat = DateFormat("HH:mm:ss").parse(time);
  return timeParseString(timeFormat);
}

timeParseString(DateTime time) {
  DateFormat dateFormat = DateFormat("HH:mm");
  return dateFormat.format(time);
}

List<AnimationTimes> mapAnimationTimes(dynamic map){
  List<AnimationTimes> list = [];
  map.forEach((e) {
     list.add(AnimationTimes.fromMap(e));
  });
  return list;
}

class AnimationTimes {
  int ?id;
  int ?daysOfWeekId;
  String ?startTime;
  String ?endTime;

  AnimationTimes({this.daysOfWeekId, this.endTime, this.id, this.startTime});

  factory AnimationTimes.fromMap(Map json) {
    AnimationTimes animationTime = AnimationTimes(
      id: json['id'] ?? null,
      daysOfWeekId: json['days_of_week_id'] ?? null,
      startTime: timeParseDateTime(json['begin_time']) ?? null,
      endTime: timeParseDateTime(json['end_time']) ?? null,
    );
    return animationTime;
  }
}