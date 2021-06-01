class FeedbackService {
  int? id;
  int? active;
  String? title;
  String? phone ;
  FeedbackService({
    this.id,
    this.title,
    this.phone,
    this.active,
  });

  factory FeedbackService.fromJSON(Map<String, dynamic> jsonMap) => FeedbackService(
    id: jsonMap['id'] ?? null,
    title: jsonMap['title'] ?? null,
    phone: jsonMap['phone'] ?? null,
    active: jsonMap['active'] ?? null,
  );
}