
class ActivitiFormModel {
  String firstName;
  String lastName;
  String phone;
  String? comments;
  int? ownerId;
  int activityId;
  DateTime date;

  ActivitiFormModel({
    required this.phone, 
    required this.activityId, 
    this.comments, 
    required this.date, 
    required this.firstName, 
    required this.lastName, 
    this.ownerId, 
  });
}