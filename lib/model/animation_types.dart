class AnimationType {
  int id;
  String value;

  AnimationType({required this.id, required this.value});

  factory AnimationType.fromJSON(Map<String, dynamic> jsonMap) => AnimationType(
    id: jsonMap['id'] ?? null,
    value: jsonMap['value'] ?? null,
  );
}