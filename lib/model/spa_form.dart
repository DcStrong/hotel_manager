
class SpaFormModel {
  String firstName;
  String lastName;
  String phone;
  String? comments;
  int? ownerId;
  int? categoryId;
  int procedureId;
  DateTime date;

  SpaFormModel({
    required this.phone, 
    this.categoryId, 
    this.comments, 
    required this.date, 
    required this.firstName, 
    required this.lastName, 
    this.ownerId, 
    required this.procedureId
  });
}