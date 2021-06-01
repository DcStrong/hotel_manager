class AnimationWeekDay {
  int? id;
  String? shortTitle;
  String? title;
  double? active = 5;

  AnimationWeekDay({this.id, this.shortTitle, this.title, this.active});

  factory AnimationWeekDay.fromJSON(Map<String, dynamic> jsonMap) => AnimationWeekDay(
    id: jsonMap['id'] ?? null,
    shortTitle: jsonMap['short_title'] ?? null,
    title: jsonMap['title'] ?? null,
  );
}